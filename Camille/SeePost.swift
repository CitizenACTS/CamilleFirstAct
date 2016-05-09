//
//  SeePost.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class SeePost: UIViewController {
    
    @IBOutlet weak var titreLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var textLbl: UITextView!
    @IBOutlet weak var votesLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    
    
    var voteRef: Firebase!
    var selectedPost: Post!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        ConfigurePost(selectedPost)

    }

    func ConfigurePost(post: Post) {
        voteRef = DataService.dataservice.REF_USER_CURRENT.childByAppendingPath("votes").childByAppendingPath(post.postKey)
        titreLbl.text = post.postTitle
        descriptionLbl.text = post.postDesc
        votesLbl.text = "\(post.postVote)"
        questionLbl.text = post.postQuestion
        
        

        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                
                self.activateBtn(true)
            } else {
                self.activateBtn(false)
            }
        })
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! CommentVC
        dest.post = selectedPost
    }
    
    func activateBtn( enabled: Bool) {
        
        self.addBtn.enabled = enabled
        self.subBtn.enabled = enabled
    }
    
    @IBAction func addVote(sender: UIButton) {
        self.selectedPost!.adjustVote(true)
        self.voteRef.setValue(true)
        activateBtn(false)
        
        self.votesLbl.text = "\(selectedPost.postVote)"
    }
    
    @IBAction func subVote(sender: UIButton) {
        self.selectedPost.adjustVote(false)
        self.voteRef.setValue(true)
        activateBtn(false)

        self.votesLbl.text = "\(selectedPost.postVote)"
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func commentBtn(sender: UIButton) {
        performSegueWithIdentifier(SEGUE_COMMENT, sender: nil)
    }
    

}
