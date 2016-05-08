//
//  Constants.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation


// URL
let URL_BASE = "https://camille.firebaseio.com"

// KEY
let KEY_UID = "uid"

// SEGUE
let SEGUE_LOG = "logged In"
let SEGUE_QUESTION = "AskQuestion"
let SEGUE_COMMENT = "CommentVC"
let SEGUE_POST = "SeePost"


// ERROR
let STATUS_ACCOUNT_NONEXIST = -8
let STATUS_ACCOUNT_WRONGEMAIL = -5
let STATUS_ACCOUNT_WRONGPASSWORD = -6

//Category



var DictCategory: [Int: [String]] = [
    1:["créer ","Produire ","Developper "],
    2:["la créativité ", "la productivité ", "le developpement "],
    3:["en création ","en production ","en devellopement "]]
var ArrayCategory = ["creer","produire","develloper"]