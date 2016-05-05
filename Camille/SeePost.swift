//
//  SeePost.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit

class SeePost: UIViewController {
    
    @IBOutlet weak var titreLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var textLbl: UITextView!
    @IBOutlet weak var votesLbl: UILabel!
    
    

    var selectedPost: Post!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        ConfigurePost(selectedPost)

    }

    func ConfigurePost(post: Post) {
        
        titreLbl.text = post.postTitle
        descriptionLbl.text = post.postDesc
        textLbl.text = post.postText
        votesLbl.text = "\(post.postVote)"
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
