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
    
    var CatRef: Firebase!
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "readyToAsk:", name: "saveQuestionEnabled", object: nil)
        
        saveNewPost.enabled = false
        descTextView.userInteractionEnabled = false
        titreTrextFiled.userInteractionEnabled = false
        // Do any additional setup after loading the view.

    }
    
    func readyToAsk(notification: NSNotification) {
        
        print("ready to ask!")
        saveNewPost.enabled = true
        descTextView.userInteractionEnabled = true
        titreTrextFiled.userInteractionEnabled = true
        
        postQuestion = notification.userInfo!["question"] as! String
        postCat1 = notification.userInfo!["cat1"] as! String
        postCat2 = notification.userInfo!["cat2"] as! String
        postCat3 = notification.userInfo!["cat3"] as! String
        
        
        
        
        
    }

    @IBAction func saveNewPost(sender: AnyObject) {
        
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
        
        
        
//        CatRef.childByAutoId().setValue(post)

        
        DataService.dataservice.REF_POSTS.childByAutoId().setValue(post)
        
        self.performSegueWithIdentifier("return", sender: nil)
        titreTrextFiled.text = ""
        descTextView.text = ""
            
        } else {
            print("error")
        }
    }

}
