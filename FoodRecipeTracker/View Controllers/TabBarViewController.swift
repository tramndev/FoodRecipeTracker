//
//  TabBarViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/24/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var bool: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentViewControllers = self.viewControllers {

            let home = currentViewControllers[0]
            let trending = currentViewControllers[1]
            let addRecipe = currentViewControllers[2]
            let notifications = currentViewControllers[3]
            let profile = currentViewControllers[4]
            let yourProfile = currentViewControllers[5]
            
            print(bool)
            
            if (feed.signedIn) {
                self.viewControllers = [home, trending, profile]
                feed.signedIn = false
                
            } else {
                self.viewControllers = [home, trending, addRecipe, notifications, yourProfile]
                self.selectedIndex = 4
            }
        }
    }
    
    func signedIn() -> Bool {
        return true
    }
}
