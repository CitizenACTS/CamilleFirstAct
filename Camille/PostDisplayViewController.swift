//
//  PostDisplayViewController.swift
//  Camille
//
//  Created by Pierre De Pingon on 16/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class PostDisplayViewController: UIViewController {
    

    var voteRef: Firebase!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    @IBOutlet weak var titreLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var votesLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostDisplayViewController.defineSelectedPost(_:)), name: "seePost", object: nil)

        ConfigurePost(selectedPost)
        // Do any additional setup after loading the view.
    }
    
    

    func ConfigurePost(post: Post) {
        voteRef = DataService.dataservice.REF_USER_CURRENT.childByAppendingPath("votes").childByAppendingPath(post.postKey)

        
        titreLbl.text = post.postTitle
        descriptionLbl.text = post.postDesc
        votesLbl.text = "Votes " + "\(post.postVote)"
        usernameLbl.text = post.userName
        

        
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                
                self.activateBtn(true)
            } else {
                self.activateBtn(false)
            }
        })
    }
    
    func defineSelectedPost(sender: NSNotification) {
        print("OKKKKKKKK")
        selectedPost = sender.userInfo!["selectedPost"] as! Post
    }
    
        func activateBtn( enabled: Bool) {
            
            self.addBtn.enabled = enabled
            self.subBtn.enabled = enabled
        }
        
        @IBAction func addVote(sender: UIButton) {
            selectedPost.adjustVote(true)
            voteRef.setValue(true)
            activateBtn(false)
            
            self.votesLbl.text = "\(selectedPost.postVote)"
        }
        
        @IBAction func subVote(sender: UIButton) {
            selectedPost.adjustVote(false)
            voteRef.setValue(true)
            activateBtn(false)
            
            self.votesLbl.text = "\(selectedPost.postVote)"
            
        }
        
        
}
