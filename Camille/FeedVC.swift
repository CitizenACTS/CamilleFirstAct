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
    
    
    var askedPosts = 0
    
    var posts = [Post]()
    var SelectedPost: Post!
    var PostPath = DataService.dataservice.REF_POSTS
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self

        ReceiveEvent()

    }


    func ReceiveEvent(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FeedVC.displayCategory(_:)), name: "MainVC", object: nil)
    }

    func displayCategory(notification: NSNotification) {
        

        
        askedPosts = notification.userInfo!["askedPost"] as! Int
        postCategory = notification.userInfo!["category"] as! String
        postCity = notification.userInfo!["city"] as! String
        
        postCityCategory = postCity + postCategory
        print("\(askedPosts) event")

        switchCategory(askedPosts)



        
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
        selectedPost = SelectedPost
        performSegueWithIdentifier(SEGUE_POST, sender: nil)

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
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
    
    func seeMyPost() {
        PostPath.queryOrderedByChild("username").queryEqualToValue(userName).observeEventType(.Value, withBlock: { snapshot in
            
            
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
            
            print(" seeMyPost ")
            
            self.tableView.reloadData()
        })
    

    }

    func seelAllCategories(){
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
                
                print(" seeAllCat ")
                
                self.tableView.reloadData()
            })
    }
    
    
    func seeCityCategory() {
        PostPath.queryOrderedByChild("cityCategory").queryEqualToValue(postCityCategory).observeEventType(.Value, withBlock: { snapshot in
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
            print(" seeByCity")
            self.tableView.reloadData()
        })
    }
    
    
    func switchCategory(sender: Int) {
        
        
        // display by categories
        

        if sender == 0 {
            seelAllCategories()
        }
        

        
        // Display by Cities and Categories
        if sender == 1 {
            seeCityCategory()
        }
        
        
        // Display my personnal post
        if sender == 2 {
            seeMyPost()
        }
        



        
        
    }
    

    

    
}
