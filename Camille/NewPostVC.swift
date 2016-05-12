//
//  NewPostVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase





class NewPostVC: UIViewController {
    

    var voteRef: Firebase!
    var postQuestion: String!
    var postCategory: [String]!

    
    var postCat1: String!
    var postCat2: String!
    var postCat3: String!



    @IBOutlet weak var titreTrextFiled: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var saveNewPost: UIButton!
    


    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        enabledSave(false)
        // Do any additional setup after loading the view.
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewPostVC.readyToAsk(_:)), name: "MainVC", object: nil)
        
    }

    

    func enabledSave(sender: Bool) {
        saveNewPost.enabled = sender
        descTextView.userInteractionEnabled = sender
        titreTrextFiled.userInteractionEnabled = sender
    }


    func readyToAsk(notification: NSNotification) {
        if notification.userInfo!["currentCount"] as! Int == 3 {
            enabledSave(true)

            postQuestion = notification.userInfo!["question"] as! String
            postCat1 = notification.userInfo!["cat1"] as! String
            postCat2 = notification.userInfo!["cat2"] as! String
            postCat3 = notification.userInfo!["cat3"] as! String
        } else {
            enabledSave(false)
        }
    }


    @IBAction func saveNewPost(sender: AnyObject) {
        

        NSNotificationCenter.defaultCenter().postNotificationName("switch", object: nil)
        
        if titreTrextFiled.text != "" && descTextView.text != "" {
        
        var post: Dictionary<String, AnyObject> = [
            "title" : titreTrextFiled.text!,
            "description" : descTextView.text!,
            "votes": 0,
            "question": postQuestion,
            "cat1": postCat1,
            "cat2": postCat2,
            "cat3": postCat3
        
        
        ]


        
        DataService.dataservice.REF_POSTS.childByAutoId().setValue(post)
        
            
            
            


        titreTrextFiled.text = ""
        descTextView.text = ""
            
        } else {
            print("error")
        }
        print(currentCategoryConstant)
    }
    

}
