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
    @IBOutlet weak var participantBtn: UIButton!
    
    @IBOutlet weak var participateBtn: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    
    
    var voteRef: Firebase!
    var commentRef: Firebase!
    var selectedPost: Post!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        userUid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        ConfigurePost(selectedPost)
        

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == SEGUE_COMMENT {
            let commentVC = segue.destinationViewController as! CommentVC
            commentVC.selectedPost = self.selectedPost
        }

    }

    func ConfigurePost(post: Post) {
        voteRef = DataService.dataservice.REF_USER_CURRENT.childByAppendingPath("votes").childByAppendingPath(post.postKey)
        commentRef = DataService.dataservice.REF_BASE.childByAppendingPath("requests").childByAppendingPath(selectedPost.postKey).childByAppendingPath(userUid)
        
        titreLbl.text = post.postTitle
        descriptionLbl.text = post.postDesc
        votesLbl.text = "\(post.postVote)"

        
        

        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                
                self.activateBtn(true)
            } else {
                self.activateBtn(false)
            }
        })
        
        askRequest()


    }
    
    func askRequest() {
        
        
        if selectedPost.userUid == userUid {
            self.participateBtn.setTitle("My Post", forState: .Normal)
        } else {
            
            
        DataService.dataservice.REF_BASE.childByAppendingPath("accepted").queryOrderedByChild("userUID").queryEqualToValue("\(self.selectedPost.postKey)\(userUid)").observeEventType(.Value, withBlock: { snapshot in
            
                print(snapshot)
                print("\(self.selectedPost.userUid)\(userUid)")
          
                if var exist = snapshot.value as? NSNull {
                    self.dontExiste()
                } else {
                    self.participateBtn.setTitle("Participate", forState: .Normal)
                }
                
            })
            
            
            
            
        }
    }
    

    func dontExiste(){
        DataService.dataservice.REF_BASE.childByAppendingPath("requests").queryOrderedByChild("userUID").queryEqualToValue("\(self.selectedPost.postKey)\(userUid)").observeEventType(.Value, withBlock: { snapshot in

            print("\(self.selectedPost.postKey)\(userUid)")
            if var exist = snapshot.value as? NSNull {
               self.participateBtn.setTitle("Ask Invitation", forState: .Normal)
            } else {
                self.doesExist()
                
            }
            
        })
    }
    func doesExist() {
        DataService.dataservice.REF_BASE.childByAppendingPath("requests").queryOrderedByChild("stateRequest").queryEqualToValue("ok?").observeEventType(.Value, withBlock: { snapshot in
            if var exist = snapshot.value as? NSNull {
               self.participateBtn.setTitle("Denied", forState: .Normal)
            } else {
               self.participateBtn.setTitle("Asking ...", forState: .Normal)
            }
            
        })
    }
    
    func activateBtn( enabled: Bool) {
        
        self.addBtn.enabled = enabled
        self.subBtn.enabled = enabled
    }
    
    func participateActivateBtn(enabled: Bool) {
        self.participateBtn.enabled = enabled
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
    
    
    @IBAction func seeParticipant(sender:UIButton) {
        self.performSegueWithIdentifier(SEGUE_PARTICPANT, sender: nil)
    }

    @IBAction func commentBtn(sender: UIButton) {
        
        let ownerUID = selectedPost.userUid
        let postTitle = selectedPost.postTitle
        let postKey = selectedPost.postKey
        
        if participateBtn.titleLabel?.text == "Ask Invitation" {
            var RequestDictionary : Dictionary<String, AnyObject> = [
                "userName" : userName,
                "selectedPost" : postKey,
                "stateRequest" : "ok?",
                "userUID" : "\(postKey)\(userUid)",
                "ownerUID" : ownerUID,
                "postTitre": postTitle
            ]
            
            DataService.dataservice.REF_BASE.childByAppendingPath("requests").childByAutoId().setValue(RequestDictionary)
            self.participateBtn.setTitle("Asking...", forState: .Normal)
 
        }
        
        if participateBtn.titleLabel?.text == "My Post" {
            performSegueWithIdentifier(SEGUE_COMMENT, sender: nil)
            print("good lord")
        }
        if participateBtn.titleLabel?.text == "Participate" {
            performSegueWithIdentifier(SEGUE_COMMENT, sender: nil)
        }
        if participateBtn.titleLabel?.text == "Denied" {
            print("denied")
        }
        
    }
    

}
