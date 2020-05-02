//
//  TabBarViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/24/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentViewControllers = self.viewControllers {

            let home = currentViewControllers[0]
            let trending = currentViewControllers[1]
            let notifications = currentViewControllers[2]
            let profile = currentViewControllers[3]
            let yourProfile = currentViewControllers[4]
                    
            if (!firebaseManager.signedIn()) {
                self.viewControllers = [home, trending, profile]
            } else {
                self.viewControllers = [home, trending, notifications, yourProfile]
                if (index == 0) {
                    index = 3
                }
            }
            viewPrepareAtIndex(index: index)
        }
    }
    
    func viewPrepareAtIndex(index: Int) {
        self.selectedIndex = index
    }
    
    func signedIn() -> Bool {
        return true
    }
}
