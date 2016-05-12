//
//  MainVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 09/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit




class MainVC: UIViewController {
    


    @IBOutlet weak var containerTableVC: UIView!
    @IBOutlet weak var containerSavePost: UIView!
    
    
    @IBOutlet weak var questionLbl: UILabel!
    

  
    
    var arrayCategoryQuest = ["", "", ""]
    var arrayCategoryPath = ["", "", ""]

  
    
    var postCategory1 = ""
    var postCategory2 = ""
    var postCategory3 = ""
    
    var postQuestion = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        questionLbl.text = "Pose une question"
        switchContainer(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.switchFromNotif), name: "switch", object: nil)
        
        

    }

    func switchFromNotif() {
        switchContainer(true)
    }
    
    
    func currentCountUpdate(identifier: Int) {
        
        currentCategoryConstant = currentCategoryConstant + 1

        if currentCategoryConstant >= 4 {
            currentCategoryConstant = 0
            arrayCategoryQuest = ["", "", ""]
            arrayCategoryPath = ["", "", ""]
            questionLbl.text = "pose une question"

        } else {
            findQuestion(identifier)
            upGradeQuest()

        }
        
        
        let postDict:[String: AnyObject] = ["currentCount": currentCategoryConstant, "question": postQuestion, "cat1" : postCategory1, "cat2": postCategory2, "cat3": postCategory3]
        NSNotificationCenter.defaultCenter().postNotificationName("MainVC", object: nil, userInfo: postDict)
        
        
    }
    
    
    func upGradeQuest(){
        questionLbl.text = "\(arrayCategoryQuest[0])\(arrayCategoryQuest[1])\(arrayCategoryQuest[2])"
        postQuestion = "\(arrayCategoryQuest[0])\(arrayCategoryQuest[1])\(arrayCategoryQuest[2])"
     
    }
    
    
    func findQuestion(identifier: Int){
        
        arrayCategoryPath[currentCategoryConstant-1] = ArrayCategory[identifier]
        arrayCategoryQuest[currentCategoryConstant-1] = DictCategory[currentCategoryConstant]![identifier]
        postCategory1 = arrayCategoryPath[0]
        postCategory2 = arrayCategoryPath[0] + arrayCategoryPath[1]
        postCategory3 = arrayCategoryPath[0] + arrayCategoryPath[1] + arrayCategoryPath[2]
        
        
        

    }
    
    // Segue




    
    
    // Navigation ContainerView
    
    func switchContainer(identifier: Bool) {
        
        if identifier {
            UIView.animateWithDuration(0.5, animations: {
                self.containerTableVC.alpha = 1
                self.containerSavePost.alpha = 0
                
            })
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.containerTableVC.alpha = 0
                self.containerSavePost.alpha = 1
            })
            
            
        }
    }


    

    //Btn Navigation
    
    @IBAction func profilBtn(sender: AnyObject) {
    }
    
    @IBAction func newPostVCBtn(sender: AnyObject) {
        switchContainer(false)

    }
    
    @IBAction func seeAllIdeas(sender: AnyObject) {
        switchContainer(true)

    }
    
    @IBAction func seeFavoriteBtn(sender: AnyObject) {
        switchContainer(true)
    }
    
    

    

    
    
    //Btn Category

    @IBAction func creerBtn(sender: AnyObject) {
        currentCountUpdate(0)

    }
    
    @IBAction func produireBtn(sender:AnyObject) {
        
    }

}
