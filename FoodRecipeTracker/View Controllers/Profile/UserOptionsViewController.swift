//
//  UserOptionsViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/24/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class UserOptionsViewController: UIViewController {
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "signInForm", sender: sender)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "signUpForm", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
