//
//  PostCell.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var usernamLabel: UILabel!
    @IBOutlet weak var voteLbl: UILabel!
    

    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCell(post: Post) {
        self.post = post
        self.titleLbl.text = post.postTitle
        self.voteLbl.text = "\(post.postVote)"
        self.descText.text = post.postDesc
        

    }

}
