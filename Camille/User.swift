//
//  User.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation


class Users {
    private var _user: String!
    private var _totalVotes: Int!
    private var _totalIdeas: Int!
    private var _ideas: [String]!
    private var _authorizations: String!
    private var _userKey: String!

    
    var user: String {
        return _user
    }
    
    var totalVotes: Int {
        return _totalVotes
    }
    
    var totalIdeas: Int {
        return _totalIdeas
    }
    
    var ideas: [String] {
        return _ideas
    }
    
    var authorizations: String {
        return _authorizations
    }
    
    var userKey: String {
        return _userKey
    }
    init(userKey: String, dictionary: AnyObject){
        self._userKey = userKey
        
        if let username = dictionary["displayName"] as? String {
            self._user = username
        }
        

        
    }
}