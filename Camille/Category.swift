//
//  Category.swift
//  Camille
//
//  Created by Pierre De Pingon on 04/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation
import Firebase


class Category {
    
    private var _CAT_REF: Firebase!
    
    var CAT_REF: Firebase {
        return _CAT_REF
    }
    

    init(catRef: Firebase){
        
        self._CAT_REF = catRef
    }
}