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
        
        
        
        
        
        
    }
    
    
    
    
}