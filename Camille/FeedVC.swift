//
//  FeedVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var CatRef: Firebase!
  
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var SelectedPost: Post!
    var PostPath = DataService.dataservice.REF_POSTS
    var ArrayCurrentCategories = ["","",""]
    
    
    var currentCategory = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
     
        switchCategory()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FeedVC.displayCategory(_:)), name: "MainVC", object: nil)

    }



    func displayCategory(notification: NSNotification) {
        ArrayCurrentCategories[0] = notification.userInfo!["cat1"] as! String
        ArrayCurrentCategories[1] = notification.userInfo!["cat2"] as! String
        ArrayCurrentCategories[2] = notification.userInfo!["cat3"] as! String
        currentCategoryConstant = notification.userInfo!["currentCount"] as! Int
        switchCategory()

    }


    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! SeePost
        dest.selectedPost = SelectedPost

        }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SelectedPost = posts[indexPath.row]
        performSegueWithIdentifier(SEGUE_POST, sender: nil)
        
        
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
    
    
    func switchCategory() {
        
        // display all categories
        if currentCategoryConstant == 0 {
            PostPath.observeEventType(.Value, withBlock: { snapshot in

                
                self.posts = []
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    for snap in snapshot {
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let post = Post(postKey: key, dictionary: postDict)
                            self.posts.append(post)

                        }
                    }
                }
                
                print(" non Category ")
                
                self.tableView.reloadData()
            })
        }
        

        if currentCategoryConstant == 1 {
            PostPath.queryOrderedByChild("cat1").queryEqualToValue(ArrayCurrentCategories[0]).observeEventType(.Value, withBlock: { snapshot in
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    self.posts = []
                    for snap in snapshot {
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let post = Post(postKey: key, dictionary: postDict)
                            self.posts.append(post)

                        }
                    }
                }
                print("Category 1")
                self.tableView.reloadData()
            })
        }
        
        
        if currentCategoryConstant == 2 {
            self.PostPath.queryOrderedByChild("cat2").queryEqualToValue(ArrayCurrentCategories[1]).observeEventType(.Value, withBlock: { snapshot in
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    self.posts = []
                    for snap in snapshot {
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let post = Post(postKey: key, dictionary: postDict)
                            self.posts.append(post)

                        }
                    }
                }
                
                print("Category 2")
                self.tableView.reloadData()
            })
        }
        
        if currentCategoryConstant == 3 {
            self.PostPath.queryOrderedByChild("cat3").queryEqualToValue(ArrayCurrentCategories[2]).observeEventType(.Value, withBlock: { snapshot in
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    self.posts = []
                    for snap in snapshot {
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let post = Post(postKey: key, dictionary: postDict)
                            self.posts.append(post)

                        }
                    }
                }
                print("Category 3")
                self.tableView.reloadData()
            })
        }
     

        
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    
}
