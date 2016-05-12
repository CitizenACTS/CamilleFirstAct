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
    private var _postQuestion: String!
    private var _postCat1: String!
    private var _postCat2: String!
    private var _postCat3: String!
    
    
    
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
    
    var postQuestion: String {
        return _postQuestion
    }
    
    var postCat1: String {
        return _postCat1
    }
    
    var postCat2: String {
        return _postCat2
    }
    
    var postCat3: String {
        return _postCat3
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
        if let question = dictionary["question"] as? String {
            self._postQuestion = question
        }
        
        if let cat1 = dictionary["cat1"] as? String {
            self._postCat1 = cat1
        }
        
        if let cat2 = dictionary["cat2"] as? String {
            self._postCat2 = cat2
        }
        
        if let cat3 = dictionary["cat3"] as? String {
            self._postCat3 = cat3
        }
        
        self._postRef = DataService.dataservice.REF_POSTS.childByAppendingPath(self._postKey)
     
        
    }
    func adjustVote(addVote: Bool) {
        if addVote {
            self._postVote = _postVote + 1
        } else {
            self._postVote = _postVote - 1
        }
        
        _postRef.childByAppendingPath("votes").setValue(_postVote)
        
    }
    
    
    
}