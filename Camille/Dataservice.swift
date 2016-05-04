//
//  Dataservice.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    
    static let dataservice = DataService()
    
    private var _REF_BASE = Firebase(url: URL_BASE)
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    
}
