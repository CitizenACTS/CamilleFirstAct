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
    var PostPath = DataService.dataservice.REF_POSTS
    var ArrayCurrentCategories = ["","",""]
    
    var currentcount = 0
    var currentCategory = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
//        
        switchCategory()
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
        if currentcount == 0 {
            PostPath.observeEventType(.Value, withBlock: { snapshot in
                //            print(snapshot.value)
                
                self.posts = []
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    for snap in snapshot {
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let post = Post(postKey: key, dictionary: postDict)
                            self.posts.append(post)
                            //                        print(post)
                        }
                    }
                }
                
                
                
                self.tableView.reloadData()
            })
        }
        
        // Display specific category
        if currentcount == 1 {
            self.PostPath.queryOrderedByChild("cat1").queryEqualToValue(ArrayCurrentCategories[0]).observeEventType(.Value, withBlock: { snapshot in
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    self.posts = []
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
        
        
        if currentcount == 2 {
            self.PostPath.queryOrderedByChild("cat2").queryEqualToValue(ArrayCurrentCategories[0] + ArrayCurrentCategories[1]).observeEventType(.Value, withBlock: { snapshot in
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    self.posts = []
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
        
        if currentcount == 3 {
            self.PostPath.queryOrderedByChild("cat3").queryEqualToValue(ArrayCurrentCategories[0] + ArrayCurrentCategories[1] + ArrayCurrentCategories[2]).observeEventType(.Value, withBlock: { snapshot in
                if let snapshot = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    self.posts = []
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
     
        
        
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    
    func stateCount(identifier: Int) {
        currentcount += 1
        if currentcount >= 4 {
            currentcount = 0
            currentCategory = ""
            ArrayCurrentCategories = ["","",""]

        } else {
            chooseCat(identifier)
        }
        
    }
    
    func chooseCat(identifier: Int) {
        print(currentcount)
        ArrayCurrentCategories[currentcount-1] = ArrayCategory[identifier]

    }

    
    
    
    
    // Bouton categorys
    
    @IBAction func creerCat(sender: UIButton) {
        stateCount(0)
        switchCategory()
    }
    
    @IBAction func produireCat(sender:UIButton) {
        stateCount(1)
        switchCategory()
    }
    
    @IBAction func developperCat(sender:UIButton) {
        stateCount(3)
        switchCategory()
    }
    


}
