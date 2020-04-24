//
//  NotificationsTableViewCell.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var notiMessage: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var notiIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
