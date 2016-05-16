//
//  NotificationVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 16/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class NotificationVC: UITableViewController, ButtonCellyesDelegate, ButtonCellnoDelegate {

    
    
    var notificationUser = [NotificationRequest]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationPath = DataService.dataservice.REF_BASE.childByAppendingPath("requests")
        userUid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        
        
        
        notificationPath.queryOrderedByChild("ownerUID").queryEqualToValue("\(userUid)").observeEventType(.Value, withBlock:{ snapshot in
            
            self.notificationUser = []
            if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                
                
                
                
                for snap in snapshot {
                    if let notifDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let notif = NotificationRequest(key: key, dict: notifDict)
                        self.notificationUser.append(notif)
                        
                    }
                }
            }
            self.tableView.reloadData()
        })
        
        
        
        
        
        
    }
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationUser.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let notif = notificationUser[indexPath.row]
        if let cell = self.tableView.dequeueReusableCellWithIdentifier("NotificationCell") as? NotificationCell {
            cell.configureCell(notif)
            if cell.buttonNoDelegate == nil {
                cell.buttonNoDelegate = self
            }
            if cell.buttonYesDelegate == nil {
                cell.buttonYesDelegate = self
            }
            
            
            
            return cell
        }
        return NotificationCell()
    }
    
    
    
    
    func cellYesTapped(cell: NotificationCell) {
        
        let path = notificationUser[tableView.indexPathForCell(cell)!.row]
        
        let dict: Dictionary<String, AnyObject> = [
            "userName" : path.userName,
            "userUID" : "\(path.userUID)",
            "selectedPost" : path.selectedPost,
            "ownerName": path.ownerUID,
            "selectedRequest" : path.requestKey
        
        ]
        DataService.dataservice.REF_BASE.childByAppendingPath("accepted").childByAutoId().setValue(dict)
        DataService.dataservice.REF_BASE.childByAppendingPath("requests").childByAppendingPath(path.requestKey).removeValue()

    }
    
    func cellNoTapped(cell: NotificationCell) {
        let path = notificationUser[tableView.indexPathForCell(cell)!.row].requestKey
        DataService.dataservice.REF_BASE.childByAppendingPath("requests").childByAppendingPath(path).childByAppendingPath("stateRequest").setValue("no!")
        
    }
    

    
}
