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
    
    @IBOutlet weak var questionLbl: UILabel!

    @IBOutlet weak var containerDisplay: UIView!
    @IBOutlet weak var containerComment: UIView!
    @IBOutlet weak var postCategoryLbl: UILabel!
    @IBOutlet weak var participateBtn: UIButton!
    
    
    

    var commentRef: Firebase!
    var selectedPost: Post!
    var currentCount = 1
    var currentState = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        postCategoryLbl.text = "\(selectedPost.city) : \(selectedPost.category)"

        
        userUid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        askRequest()
        
        if currentState == 0 {
            self.participateBtn.titleLabel?.text == "Ask Invitation"
        }
        if currentState == 1 {
            self.participateBtn.titleLabel?.text == "Asking ..."
        }
        if currentState == 2 {
            self.participateBtn.titleLabel?.text == "Denied"
            self.participateBtn.enabled = false
        }
        if currentState == 3 {
            self.participateBtn.titleLabel?.text == "Participate"
        }
        if currentState == 4 {
            self.participateBtn.titleLabel?.text == "My Post"
        }
        

    }
    
    


    
    func askRequest() {
        
        
        if selectedPost.userUid == userUid {
            self.currentState = 4
        } else {
            
            
        DataService.dataservice.REF_BASE.childByAppendingPath("accepted").queryOrderedByChild("userUID").queryEqualToValue("\(self.selectedPost.postKey)\(userUid)").observeEventType(.Value, withBlock: { snapshot in
            
          
                if var exist = snapshot.value as? NSNull {
                    self.dontExiste()
                } else {
                    self.currentState = 3
                    self.stateBtn(self.currentState)
                }
                
            })
            
            
            
            
        }
    }
    

    func dontExiste(){
        DataService.dataservice.REF_BASE.childByAppendingPath("requests").queryOrderedByChild("userUID").queryEqualToValue("\(self.selectedPost.postKey)\(userUid)").observeEventType(.Value, withBlock: { snapshot in

            print("\(self.selectedPost.postKey)\(userUid)")
            if var exist = snapshot.value as? NSNull {
               self.currentState = 0
                self.stateBtn(self.currentState)
            } else {
                self.doesExist()
                
            }
            
        })
    }
    func doesExist() {
        DataService.dataservice.REF_BASE.childByAppendingPath("requests").queryOrderedByChild("stateRequest").queryEqualToValue("ok?").observeEventType(.Value, withBlock: { snapshot in
            if var exist = snapshot.value as? NSNull {
               self.currentState = 2
                self.stateBtn(self.currentState)
            } else {
               self.currentState = 1
                self.stateBtn(self.currentState)
            }
            
        })
    }
    
    func switchContainer(sender: Bool) {
        if sender {
            UIView.animateWithDuration(0.5, animations: {
                self.containerComment.alpha = 1.0
                self.containerDisplay.alpha = 0.0
            })

        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.containerComment.alpha = 0.0
                self.containerDisplay.alpha = 1.0
            })
        }
    }



    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func stateBtn(sender : Int) {
        
        let ownerUID = selectedPost.userUid
        let postTitle = selectedPost.postTitle
        let postKey = selectedPost.postKey
        
        // Invitation
        if sender == 0 {
            var RequestDictionary : Dictionary<String, AnyObject> = [
                    "userName" : userName,
                    "selectedPost" : postKey,
                    "stateRequest" : "ok?",
                    "userUID" : "\(postKey)\(userUid)",
                    "ownerUID" : ownerUID,
                    "postTitre": postTitle
                ]
                
                DataService.dataservice.REF_BASE.childByAppendingPath("requests").childByAutoId().setValue(RequestDictionary)
        }
        
        // Asking
        if sender == 1 {
            participateBtn.titleLabel?.text = "Asking..."
            
        }
        // Denied
        if sender == 2 {
            participateBtn.titleLabel?.text = "Denied"
 

            
        }
        // Participate
        if sender == 3 {
            participateBtn.titleLabel?.text = "Participate"

            
        }
        // Owner
        if sender == 4 {
            participateBtn.titleLabel?.text = "MyPost"

            
        }
        
    }
    

        func refreshCount(){
            currentCount += 1
            if currentCount > 1 {
                currentCount = 0
            }
        }
    func actualState(sender: Int) {
        currentState = sender
        
    }
    
    @IBAction func commentBtn(sender: UIButton) {
        if currentState >= 3 {
        refreshCount()
        if currentCount == 1 {
            stateBtn(currentState)
            switchContainer(true)

        }
        
        else {
            self.participateBtn.setTitle("See Post", forState: .Normal)
            switchContainer(false)
        }
        } else {
            stateBtn(currentState)
        }
        print(currentState)

        

    }
    

}
