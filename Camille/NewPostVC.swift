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
    var postCategory: String!
    var postCity: String!
    var postCityCategory: String!



    @IBOutlet weak var titreTrextFiled: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var saveNewPost: UIButton!
    


    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
//        enabledSave(false)

        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewPostVC.readyToAsk(_:)), name: "MainVC", object: nil)
        
    }

    

    func enabledSave(sender: Bool) {
        saveNewPost.enabled = sender
        descTextView.userInteractionEnabled = sender
        titreTrextFiled.userInteractionEnabled = sender
        
    }


    func readyToAsk(notification: NSNotification) {
            enabledSave(true)
            postCategory = notification.userInfo!["category"] as! String
            postCity = notification.userInfo!["city"] as! String

    }


    @IBAction func saveNewPost(sender: AnyObject) {
        

        NSNotificationCenter.defaultCenter().postNotificationName("switch", object: nil)
  
        
        if titreTrextFiled.text != "" && descTextView.text != "" {
            
            postCityCategory = "\(postCity)\(postCategory)"
        

        var post: Dictionary<String, AnyObject> = [
            "title" : titreTrextFiled.text!,
            "description" : descTextView.text!,
            "votes": 0,
            "category": postCategory,
            "city": postCity,
            "cityCategory" : postCityCategory,
            "username" : userName,
            "userUid" : userUid
        ]
        DataService.dataservice.REF_POSTS.childByAutoId().setValue(post)
            
        titreTrextFiled.text = ""
        descTextView.text = ""
        } else {
            print("error Save")
        }
    }
    

}
