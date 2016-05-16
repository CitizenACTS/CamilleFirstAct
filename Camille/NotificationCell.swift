//
//  NotificationCell.swift
//  Camille
//
//  Created by Pierre De Pingon on 15/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase


protocol ButtonCellyesDelegate {

    func cellYesTapped(cell: NotificationCell)
}
protocol ButtonCellnoDelegate {
    
    func cellNoTapped(cell: NotificationCell)
}

class NotificationCell: UITableViewCell {
    
    var buttonYesDelegate: ButtonCellyesDelegate?
    var buttonNoDelegate: ButtonCellnoDelegate?
    
    
    @IBOutlet weak var titreLbl : UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var yesPressed: UIButton!
    @IBOutlet weak var noPressed: UIButton!
    
    var notif : NotificationRequest!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(notif: NotificationRequest) {
        self.titreLbl.text = notif.postTitre
        self.usernameLbl.text = notif.userName
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func noPressed(sender: AnyObject) {
        if let delegate = buttonNoDelegate {
            delegate.cellNoTapped(self)
        }
    }

    @IBAction func yesPressed(sender: AnyObject) {
        if let delegate = buttonYesDelegate {
            delegate.cellYesTapped(self)
        }
    }
    

}
