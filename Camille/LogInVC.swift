//
//  LogInVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LogInVC: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOG, sender: nil)
        }
    }
    
    
    @IBAction func fbBtnPressed(sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            if facebookError != nil {
                print("Facebook login error \(facebookError)")
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("SUCESSE LOG IN ")
                
                
                DataService.dataservice.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    if error != nil {
                        print("login fail")
                    } else {
                        print("login")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        let user = [
                            
                            "provider" : authData.provider,
                            "displayName" : authData.providerData["displayName"] as? NSString as? String,
                            "email" : authData.providerData["email"] as? NSString as? String
                        ]
                        
                        DataService.dataservice.createFirebaseUser(authData.uid, user: user)
                        self.performSegueWithIdentifier(SEGUE_LOG, sender: nil)
                    }
                })
            }
        }
        
    }
    


    
      
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}
