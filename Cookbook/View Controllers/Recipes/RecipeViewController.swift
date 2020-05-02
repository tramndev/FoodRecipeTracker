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
    @IBOutlet var timeStamp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImage.image = chosenRecipe.image
        recipeName.text = chosenRecipe.name
        recipeBriefDescription.text = chosenRecipe.description
        servings.text = "\(chosenRecipe.servings)"
        prepTime.text = "\(chosenRecipe.prepTime)"
        cookTime.text = "\(chosenRecipe.cookTime)"
        ingredients.text = chosenRecipe.ingredients
        instructions.text = chosenRecipe.instructions
        notes.text = chosenRecipe.notes
        timeStamp.text = feed.formatDate(date: chosenRecipe.dateEntry)
        
        if (chosenRecipe.owner === feed.getCurrUser()) {
            recipeOwner.isEnabled = false
            recipeOwner.setTitle("me", for: .normal)
        }
        recipeOwner.setTitle(chosenRecipe.owner?.name, for: .normal)
    }
    override func viewWillLayoutSubviews() {
           ingredients.sizeToFit()
       }
    
    @IBAction func recipeOwnerNamePressed(_ sender: Any) {
        performSegue(withIdentifier: "showRecipeOwner", sender: chosenRecipe.owner)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UserRecipeViewController, let recipeOwner = sender as? User  {
            dest.guestUser = recipeOwner
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        // Add func like
        print(chosenRecipe.name)
        // Add like function
    }
}
