//
//  CommentVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 07/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class CommentVC: UIViewController {
    
    var post: Post!
    
    @IBOutlet weak var titreLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titreLbl.text = post.postTitle
    }

    @IBAction func backBtn(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
