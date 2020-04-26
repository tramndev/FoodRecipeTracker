//
//  RecipeViewController.swift
//  Cookbook
//
//  Created by Tram Nguyen on 4/25/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var chosenRecipe: Recipe!
    
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var recipeOwner: UIButton!
    @IBOutlet var recipeBriefDescription: UILabel!
    @IBOutlet var servings: UILabel!
    @IBOutlet var prepTime: UILabel!
    @IBOutlet var cookTime: UILabel!
    @IBOutlet var ingredients: UILabel!
    @IBOutlet var instructions: UILabel!
    @IBOutlet var notes: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImage.image = chosenRecipe.image
        recipeName.text = chosenRecipe.name
        recipeOwner.setTitle(chosenRecipe.owner?.name, for: .normal)
        recipeBriefDescription.text = chosenRecipe.description
        servings.text = "\(chosenRecipe.servings)"
        prepTime.text = "\(chosenRecipe.prepTime)"
        cookTime.text = "\(chosenRecipe.cookTime)"
        ingredients.text = chosenRecipe.ingredients
        instructions.text = chosenRecipe.instructions
        notes.text = chosenRecipe.notes
    }
}
