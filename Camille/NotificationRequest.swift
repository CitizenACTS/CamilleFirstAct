//
//  NotificationRequest.swift
//  Camille
//
//  Created by Pierre De Pingon on 15/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation

class NotificationRequest {
    private var _userUID: String!
    private var _ownerUID: String!
    private var _selectedPost: String!
    private var _userName: String!
    private var _stateRequest: String!
    private var _requestKey: String!
    private var _postTitre: String!
    
    var userUID: String {
        return _userUID
    }
    var ownerUID: String {
        return _ownerUID
    }
    var selectedPost: String {
        return _selectedPost
    }
    
    var userName: String {
        return _userName
    }
    
    var stateRequest: String {
        return _stateRequest
    }
    
    var requestKey: String {
        return _requestKey
    }
    
    var postTitre: String {
        return _postTitre
    }
    
    init(key: String, dict: Dictionary<String, AnyObject>){
        self._requestKey = key

        if let userUID = dict["userUID"] as? String {
            self._userUID = userUID
        }
        if let ownerUID = dict["ownerUID"] as? String {
            self._ownerUID = ownerUID
        }
        if let selectedPost = dict["selectedPost"] as? String {
            self._selectedPost = selectedPost
        }
        if let userName = dict["userName"] as? String {
            self._userName = userName
        }
        if let stateRequest = dict["stateRequest"] as? String {
            self._stateRequest = stateRequest
        }
        if let postTitre = dict["postTitre"] as? String {
            self._postTitre = postTitre
        }
    }
    
    

}