//
//  UserSignInViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/24/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class UserSignInViewController: UIViewController {
    @IBOutlet weak var usenameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        if (allInputFilled()) {
            guard let email = usenameInput.text, let password = passwordInput.text else { return }
            firebaseManager.signIn(email: email, pass: password) {[weak self] (success) in
                if (success) {
                    // Present "Profile" tab bar
                    self?.performSegue(withIdentifier: "signedIn", sender: sender)
                } else {
                    // Catch Firebase log-in errors
                    let alert = UIAlertController(title: "Whoops! Something went wrong", message: "We are not able to find an account with that email and password combination. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")}))
                    self!.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            // Require textfield inputs
            let alert1 = UIAlertController(title: "Authentication Required", message: "Please enter your email and password to sign in", preferredStyle: .alert)
            alert1.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")}))
            self.present(alert1, animated: true, completion: nil)
        }
    }
    
    func allInputFilled()->Bool {
        if usenameInput.text != "" || passwordInput.text != "" {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? TabBarViewController {
            dest.index = 4
        }
    }
}
