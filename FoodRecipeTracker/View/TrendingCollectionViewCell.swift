//
//  TrendingCollectionViewCell.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trendingRecipeImage: UIImageView!
    @IBOutlet weak var trendingRecipeName: UILabel!
    @IBOutlet weak var recipeBackground: UIStackView!
    @IBOutlet weak var likeButton: UIButton!
}
