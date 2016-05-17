//
//  Constants.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation
import UIKit

var selectedPost: Post!


// colors
let SHADOW_COLOR: CGFloat = 157.0/255


// URL
let URL_BASE = "https://camille.firebaseio.com"


// USER

var userName: String!
var userUid: String!

// KEY
let KEY_UID = "uid"

// SEGUE

let SEGUE_PARTICPANT = "SeeParticipant"
let SEGUE_LOG = "logged In"
let SEGUE_QUESTION = "AskQuestion"
let SEGUE_DISPLYPOST = "PostDisplayViewController"
let SEGUE_COMMENT = "CommentVC"
let SEGUE_POST = "SeePost"


// ERROR
let STATUS_ACCOUNT_NONEXIST = -8
let STATUS_ACCOUNT_WRONGEMAIL = -5
let STATUS_ACCOUNT_WRONGPASSWORD = -6

//Category

var pickerDataSource = [["Paris","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes","Lyon","Marseilles2","Toulouse1", "Bordeaux", "Rennes","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes","Lyon","Marseilles1","Toulouse2", "Bordeaux", "Rennes","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes","Lyon2","Marseilles","Toulouse", "Bordeaux3", "Rennes3","Lyon3","Marseilles3","Toulouse3", "Bordeaux4", "Rennes","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes","Lyon","Marseilles","Toulouse", "Bordeaux", "Rennes"],["1", "2", "3", "4","5"],["1", "2", "3", "4", "5"],["1", "2", "3", "4","5"]];

var postCategory = "111"
var postCity = "Paris"
var postCityCategory = "Paris111"
var askedPosts =  0



var DictCategory: [Int: [String]] = [
    1:["créer ","Produire ","Developper "],
    2:["la créativité ", "la productivité ", "le developpement "],
    3:["en création ","en production ","en devellopement "]]
var ArrayCategory = ["creer","produire","develloper"]