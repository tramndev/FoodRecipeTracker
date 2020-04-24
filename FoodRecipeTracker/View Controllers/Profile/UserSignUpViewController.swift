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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "signedIn", sender: sender)
    }
}
