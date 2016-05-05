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
    
    @IBOutlet weak var titreTrextFiled: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var textTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveNewPost(sender: AnyObject) {
        var post: Dictionary<String, AnyObject> = [
            "title" : titreTrextFiled.text!,
            "description" : descTextView.text!,
            "votes": 0
        
        
        
        ]
        
        if textTextView.text != "" {
            post["text"] = textTextView.text
        }
        CatRef.childByAutoId().setValue(post)
        print(post)
        performSegueWithIdentifier("SaveQuestion", sender: nil)
    }

}
