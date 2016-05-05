//
//  Post.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    
    
    private var _postTitle: String!
    private var _postDesc: String!
    private var _postText: String!
    private var _postVote: Int!
    private var _postKey: String!
    private var _username: String!
    private var _postRef: Firebase!
    private var _postQuestion: Firebase!
    
    
    
    var postTitle: String {
        return _postTitle
    }
    
    var postDesc: String {
        
        return _postDesc
    }
    
    var postText: String {
        return _postText
    }
    
    
    var postVote: Int {
        return _postVote
    }
    
    
    var postKey: String {
        return _postKey
    }
    
    
    init(username: String, title: String, desc: String, text: String) {
        
        self._postTitle = title
        self._username = username
        self._postText = text

        
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        if let votes = dictionary["votes"] as? Int {
            self._postVote = votes
        }
        if let title = dictionary["title"] as? String {
            self._postTitle = title
        }
        if let desc = dictionary["description"] as? String {
            self._postDesc = desc
        }
        if let text = dictionary["text"] as? String {
            self._postText = text
        }
     
        
    }
    
    
    
}