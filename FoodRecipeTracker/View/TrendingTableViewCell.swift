//
//  TrendingTableViewCell.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var recipeTimeStamp: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeBriefDescription: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
