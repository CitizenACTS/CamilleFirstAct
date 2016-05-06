//
//  CategorieVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class CategorieVC: UIViewController {
    
    
    @IBOutlet weak var questionLbl: UILabel!
    
    var ArrayCatQuestion = ["","",""]
    var ArrayCatFirebase = ["","",""]
    
    var currentcount = 0
    var CatRef: Firebase!
    var postQuestion: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLbl.text = "\(ArrayCatQuestion[0])\(ArrayCatQuestion[1])\(ArrayCatQuestion[2])"
   
    }
    

   
    
    func saveQuestion() {
        currentcount += 1
        if currentcount >= 4 {
            currentcount = 1
            ArrayCatQuestion = ["","",""]
            ArrayCatFirebase = ["","",""]
            
        }
        

        
    }
    func SaveCategorie(identifier: String) {
        
        var currentCategory = 0
        var Quest = DictCategory
        var cat = ArrayCategory
        
        for x in 0...cat.count-1 {
            if cat[x] == identifier {
              currentCategory += x
            }
        }
//        print("category \(currentCategory)")
//        print("count\(currentcount)")
        
 
        ArrayCatFirebase[currentcount-1] = cat[currentCategory]

        ArrayCatQuestion[currentcount-1] = Quest[currentcount]![currentCategory]

        questionLbl.text = "\(ArrayCatQuestion[0])\(ArrayCatQuestion[1])\(ArrayCatQuestion[2])"
        postQuestion = "\(ArrayCatFirebase[0])\(ArrayCatFirebase[1])\(ArrayCatFirebase[2])"
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! NewPostVC
        dest.CatRef = CatRef
        dest.postQuestion = postQuestion
      
    }
    
    @IBAction func AskQuestion(sender: UIButton) {
        
        if ArrayCatFirebase[0] != "" && ArrayCatFirebase[1] != "" && ArrayCatFirebase[2] != "" {
        
        CatRef = DataService.dataservice.REF_POSTS.childByAppendingPath("\(ArrayCatFirebase[0])/\(ArrayCatFirebase[1])/\(ArrayCatFirebase[2])/")

           performSegueWithIdentifier(SEGUE_QUESTION, sender: nil)
        }
        
    }
    
    @IBAction func creerBtn(sender: UIButton) {
        saveQuestion()
         SaveCategorie("creer")
        


    }

    @IBAction func produireBtn(sender: UIButton) {
        saveQuestion()
        SaveCategorie("produire")


    }


}
