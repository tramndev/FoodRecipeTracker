//
//  AddRecipeViewController.swift
//  Cookbook
//
//  Created by Tram Nguyen on 4/25/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {
    
    var imagePickerController: UIImagePickerController!
    @IBOutlet var photoButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var photoIcon: UIImageView!
    @IBOutlet var cameraIcon: UIImageView!
    
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeName: UITextField!
    @IBOutlet var recipeOwner: UILabel!
    @IBOutlet var recipeBriefDescription: UITextField!
    @IBOutlet var servings: UITextField!
    @IBOutlet var ingredients: UITextField!
    @IBOutlet var cookTime: UITextField!
    @IBOutlet var prepTime: UITextField!
    @IBOutlet var instructions: UITextField!
    @IBOutlet var notes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        self.imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true) {
        }
    }
    
    
    @IBAction func photoButtonPressed(_ sender: Any) {
        self.imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true) {
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let servingsInt:Int? = Int(servings.text!)
        let cookTimeInt:Int? = Int(cookTime.text!)
        let prepTimeInt:Int? = Int(prepTime.text!)

        let myRecipe: Recipe = Recipe(
            name: recipeName.text!,
            description: recipeBriefDescription.text!,
            servings: servingsInt!,
            prepTime: cookTimeInt!,
            cookTime: prepTimeInt!,
            ingredients: ingredients.text!,
            instructions: instructions.text!,
            notes: notes.text!,
            image: recipeImage.image!
        )

        feed.getCurrUser()?.addRecipe(recipe: myRecipe)
        performSegue(withIdentifier: "showRecipe", sender: sender)
    }
}

extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            recipeImage.image = image
            
            cameraButton.isEnabled = false
            photoButton.isEnabled = false
            cameraIcon.isHidden = true
            photoIcon.isHidden = true
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RecipeViewController, let addedRecipe = sender as? Recipe  {
            dest.chosenRecipe = addedRecipe
        }
    }
}
