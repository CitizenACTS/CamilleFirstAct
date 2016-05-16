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
    private var _userUid: String!
    private var _postRef: Firebase!
    private var _postCategory: String!
    private var _postCity: String!
    
    
    var userUid: String {
        return _userUid
    }
    
    var postCity: String {
        return _postCity
    }
    
    
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
    
    
    var category: String {
        return _postCategory
    }
    
    var city: String {
        return _postCity
    }
    
    var userName: String {
        return _username
    }
    

    
    init(username: String, title: String, desc: String, text: String) {
        
        self._postTitle = title
        self._username = username
        self._postText = text

        
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let userUid = dictionary["userUid"] as? String {
            self._userUid = userUid
        }

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
        
        if let category = dictionary["category"] as? String {
            self._postCategory = category
        }
        
        if let userName = dictionary["username"] as? String {
            self._username = userName
        }
        
        
        if let postCity = dictionary["city"] as? String {
            self._postCity = postCity
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