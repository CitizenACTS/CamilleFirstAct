//
//  ContainerViewController.swift
//  Camille
//
//  Created by Pierre De Pingon on 09/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var firstVC: FeedVC?
    
    var vc : UIViewController!
    var segueIdentifier : String!
    var lastViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segueIdentifierReceivedFromParent("buttonOne")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueIdentifierReceivedFromParent(button: String){
        if button == "buttonOne"
        {
            
            self.segueIdentifier = "first"
            self.performSegueWithIdentifier(self.segueIdentifier, sender: nil)
            
        }
        else if button == "buttonTwo"
        {
            
            self.segueIdentifier = "second"
            self.performSegueWithIdentifier(self.segueIdentifier, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueIdentifier{
            //Avoids creation of a stack of view controllers
            if lastViewController != nil{
                lastViewController.view.removeFromSuperview()
            }
            //Adds View Controller to Container "first" or "second"
            vc = segue.destinationViewController 
            self.addChildViewController(vc)
            vc.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(vc.view)
            vc.didMoveToParentViewController(self)
            lastViewController = vc
            
        }
    }
}