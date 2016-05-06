//
//  FeedVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var CatRef: Firebase!
  
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var SelectedPost: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
//        DataService.dataservice.REF_POSTS.childByAppendingPath("creer").childByAppendingPath("creer").childByAppendingPath("creer").observeEventType(.Value, withBlock: { snapshot in
        DataService.dataservice.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
            
            self.posts = []
            if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                        print(post)
                    }
                }
            }
            
            self.tableView.reloadData()
        })
       
    }



    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! SeePost
        dest.selectedPost = SelectedPost
//        print(SelectedPost)
        }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SelectedPost = posts[indexPath.row]
        performSegueWithIdentifier("SeePost", sender: nil)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else {
            return PostCell()
        }
    }

}
