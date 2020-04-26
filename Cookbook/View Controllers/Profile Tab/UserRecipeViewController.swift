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
    // Get the signed-in user
    let currUser: User = feed.getCurrUser()!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var memberSince: UILabel!
    @IBOutlet var achievements: UILabel!
    @IBOutlet var userName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userRecipeTableView.delegate = self
        userRecipeTableView.dataSource = self
        
        userName.text = currUser.name
        memberSince.text = "Member since \(currUser.getYearEntry())"
        achievements.text = "Shared \(currUser.getRecipesCount()) dishes | \(currUser.getFollowersCount()) followers"
        userImage.image = currUser.image
    }

    override func viewWillAppear(_ animated: Bool) {
        userRecipeTableView.reloadData()
    }
        
    // TRENDING TABLE VIEW SETUP
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recipes = feed.sortRecipeFollowing(user: currUser)
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userRecipeTableVewCell", for: indexPath) as? UserRecipeTableViewCell {

            // configure TrendingTableCell
            let recipes = feed.sortRecipeFollowing(user: currUser)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(currUser.name)
        let chosenRecipe = feed.sortRecipeFollowing(user: currUser)[indexPath.item]
        performSegue(withIdentifier: "showRecipe", sender: chosenRecipe)
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        firebaseManager.signOut()
        performSegue(withIdentifier: "signedOut", sender: sender)
    }
    
    @IBAction func addRecipeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "addRecipe", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RecipeViewController, let chosenRecipe = sender as? Recipe  {
            dest.chosenRecipe = chosenRecipe
        }
    }
}
