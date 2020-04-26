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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewNextEntry()
    }
    
    func viewNextEntry() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
