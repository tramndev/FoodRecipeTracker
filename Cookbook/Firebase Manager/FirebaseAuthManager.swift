//
//  FirebaseAuthManager.swift
//  Cookbook
//
//  Created by Tram Nguyen on 4/25/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

var firebaseManager = FirebaseAuthManager()

class FirebaseAuthManager {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }

    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    func signedIn() -> Bool {
        print (Auth.auth().currentUser != nil)
        return Auth.auth().currentUser != nil
    }
    
    func getCurrUserEmail() -> String {
        var email: String = ""
        let user = Auth.auth().currentUser
        if let user = user {
            email = user.email!
        }
        return email
    }
}
