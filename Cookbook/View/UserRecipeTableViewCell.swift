//
//  UserRecipeTableViewCell.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

protocol UserRecipeTableViewCellDelegate {
    func didTapLikeButton(recipe: Recipe)
}

class UserRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var recipeBriefDescription: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet var likeButton: UIButton!
    var delegate: UserRecipeTableViewCellDelegate?
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        delegate?.didTapLikeButton(recipe: feed.getRecipe(recipeName: recipeName.text!)!)
        likeButton.isEnabled = false
        likeButton.setImage(UIImage(named: "heart-4"), for: .disabled)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
