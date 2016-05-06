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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

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
                        let user = ["provider": authData.provider!]
                        DataService.dataservice.createFirebaseUser(authData.uid, user: user)
                        self.performSegueWithIdentifier(SEGUE_LOG, sender: nil)
                    }
                })
            }
        }
        
    }
    @IBAction func attempteLogin(sender: UIButton!) {
        
        if let email = emailTextField.text where email != "", let pwd = passwordTextField.text where pwd != "" {
            
            DataService.dataservice.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                if error != nil {
                    
                    if error.code == STATUS_ACCOUNT_WRONGPASSWORD {
                        self.showErrorAlert("Wrong Password", msg: "Please enter your password")
                    }
                    if error.code == STATUS_ACCOUNT_NONEXIST {
                        DataService.dataservice.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
                                
                            } else {
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                DataService.dataservice.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { err, authData in
                                    
                                    let user = ["provider": authData.provider!, "email": email]
                                    DataService.dataservice.createFirebaseUser(authData.uid, user: user)
                            })
                
                    
                            self.performSegueWithIdentifier(SEGUE_LOG, sender: nil)
                                
                        }
                        })
                    } else {
                        self.showErrorAlert("Could not log", msg: "Pls check password")
                    }
                    
                    if error.code == STATUS_ACCOUNT_WRONGEMAIL {
                        self.showErrorAlert("Invalid Email", msg: "Please enter a valid mail")
                        
                    }
                    
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOG, sender: nil)
                }
            })
            
        } else {
            showErrorAlert("Email and Password", msg: "You must enter an email and a password")
        }
        
        
        
    }
    
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
}
