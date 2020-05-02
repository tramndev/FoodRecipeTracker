//
//  RecipesTableCell.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

protocol RecipeTableCellDelegate {
    func didTapLikeButton(recipe: Recipe)
}

class RecipesTableCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeBriefDescription: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    var delegate: RecipeTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        delegate?.didTapLikeButton(recipe: feed.getRecipe(recipeName: recipeName.text!)!)
        likeButton.isEnabled = false
        likeButton.setImage(UIImage(named: "heart-4"), for: .disabled)
    }
}
