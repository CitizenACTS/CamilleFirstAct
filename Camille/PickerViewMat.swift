//
//  File.swift
//  Camille
//
//  Created by Pierre De Pingon on 16/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation

import UIKit


class PickerViewMat: UIPickerView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 1.0).CGColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    
}