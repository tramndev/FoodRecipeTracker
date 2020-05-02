//
//  TrendingCollectionViewCell.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

protocol TrendingCollectionViewCellDelegate {
    func didTapLikeButton(recipe: Recipe)
}

class TrendingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trendingRecipeImage: UIImageView!
    @IBOutlet weak var trendingRecipeName: UILabel!
    @IBOutlet weak var recipeBackground: UIStackView!
    @IBOutlet weak var likeButton: UIButton!
    var delegate: TrendingCollectionViewCellDelegate?
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        delegate?.didTapLikeButton(recipe: feed.getRecipe(recipeName: trendingRecipeName.text!)!)
        likeButton.isEnabled = false
        likeButton.setImage(UIImage(named: "heart-4"), for: .disabled)
    }
}
