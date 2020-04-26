//
//  TrendingViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/23/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var trendingTableView: UITableView!
    let recipes = feed.sortRecipeFollowing(method: "trending")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trendingTableView.reloadData()
        trendingTableView.reloadData()
    }
    
    // TRENDING TABLE VIEW SETUP
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTableView", for: indexPath) as? TrendingTableViewCell {
            // configure TrendingTableCell
            let currRecipe = recipes[indexPath.row]

            cell.userImage.image = currRecipe.owner?.image
            cell.recipeTimeStamp.text = feed.formatDate(date: currRecipe.dateEntry)
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
        let chosenRecipe = recipes[indexPath.item]
        performSegue(withIdentifier: "showRecipe", sender: chosenRecipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RecipeViewController, let chosenRecipe = sender as? Recipe  {
            dest.chosenRecipe = chosenRecipe
        }
    }
}
