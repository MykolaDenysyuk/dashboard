//
//  WorldViewCell.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class WorldViewCell: UITableViewCell {

    // MARK: Vars
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var detailsLabel:UILabel!
    @IBOutlet weak var isOnlineView:UIView!
    
    var isOnline:Bool = false {
        didSet {
            self.isOnlineView.backgroundColor = isOnline ?
                UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
            :   UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
        }
    }
    
    // MARK: Actions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = frame.width - 20
        detailsLabel.preferredMaxLayoutWidth = nameLabel.preferredMaxLayoutWidth
    }
    
    func configureWith(world:WorldViewModel) {
        nameLabel.text = world.name
        detailsLabel.text = world.details
        isOnline = world.isOnline
        
    }
    
}
