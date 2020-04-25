//
//  UserRecipeViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/24/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class UserRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userRecipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userRecipeTableView.delegate = self
        userRecipeTableView.dataSource = self
    }

    // TRENDING TABLE VIEW SETUP
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recipes = feed.sortRecipeFollowing(method: "user")
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userRecipeTableVewCell", for: indexPath) as? UserRecipeTableViewCell {

            // configure TrendingTableCell
            let recipes = feed.sortRecipeFollowing(method: "user")
            for r in recipes {
                print(r.name)
            }
            print(indexPath.row)
            let currRecipe = recipes[indexPath.row]

            cell.userImage.image = currRecipe.owner?.image
            cell.timeStamp.text = feed.formatDate(date: currRecipe.dateEntry)
            cell.userNickName.text = "@\(currRecipe.owner!.nickName)"
            cell.userName.text = currRecipe.owner?.name
            cell.recipeName.text = currRecipe.name
            cell.recipeImage.image = currRecipe.image
            cell.recipeBriefDescription.text = currRecipe.description

            return cell
        }
        return UITableViewCell()
      }

    // Returns a concise string corresponding to time since post
    func formatDate(date: Date) -> String {
        // returns a concise string corresponding to time since post
        let minutesAgo =  -Int((date.timeIntervalSinceNow / 60))
        return "\(minutesAgo) minutes ago"
    }
    
    

}
