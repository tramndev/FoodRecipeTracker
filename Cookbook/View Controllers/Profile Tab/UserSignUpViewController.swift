//
//  UserSignUpViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/24/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class UserSignUpViewController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var useNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var cameraIcon: UIImageView!
    @IBOutlet var photoIcon: UIImageView!
    @IBOutlet var photoButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    
    var imagePickerController: UIImagePickerController!
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        signUpButton.isHidden = false
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
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        // Create authentication on Firebase
        if (allInputFilled()) {
            if let email = emailInput.text, let password = passwordInput.text {
                firebaseManager.createUser(email: email, password: password) {[weak self] (success) in
                    if (success) {
                        //Create new user
                        let newUser: User = User(
                            name: self!.nameInput.text!,
                            image: self!.profileImage.image!,
                            user: self!.useNameInput.text!,
                            pass: self!.passwordInput.text!,
                            email: self!.emailInput.text!
                        )
                        feed.addUser(user: newUser)
                        // Present alert and show "Add Recipe" tab bar
                        let alert = UIAlertController(title: "You are all set!", message: "Let's create your first new dish.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Sure", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                            self?.performSegue(withIdentifier: "signedUp", sender: sender)
                        }))
                        self?.present(alert, animated: true, completion: nil)
                    } else {
                        // Catch Firebase log-in errors
                        let alert = UIAlertController(title: "Error", message: "Cannot create user account", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")}))
                        self!.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            // Require textfield inputs
            let alert1 = UIAlertController(title: "Authentication Required", message: "All fields are required to sign up. Please try again", preferredStyle: .alert)
            alert1.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")}))
            self.present(alert1, animated: true, completion: nil)
        }
    }
    
    func allInputFilled()->Bool {
        if nameInput.text != "" || emailInput.text != ""
            || useNameInput.text != "" || passwordInput.text != ""
        || profileImage.image != nil {
            return true
        }
        return false
    }
}

extension UserSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
            
            cameraButton.isEnabled = false
            photoButton.isEnabled = false
            cameraIcon.isHidden = true
            photoIcon.isHidden = true
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}
