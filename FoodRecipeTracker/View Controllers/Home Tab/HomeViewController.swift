//
//  HomeViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var recipeTableView: UITableView!
    var likes: [Bool]!
    
    // TRENDING COLLECTION VIEW SETUP
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let recipe = feed.recipes[index]
        
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trendingCollectionViewCell", for: indexPath) as? TrendingCollectionViewCell {
            
             // configure TrendingCollectionViewCell
            cell.trendingRecipeImage.image = recipe.image
            cell.trendingRecipeName.text = recipe.name

            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // RECIPE TABLE VIEW SETUP
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 325
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recipesTableCell", for: indexPath) as? RecipesTableCell {
            
            // configure RecipesTableCell
            let recieps = feed.sortRecipeFollowing(method: "recently")
            let currRecipe = recieps[indexPath.row]
            
            cell.userImage.image = currRecipe.owner?.image
            cell.timeStamp.text = formatDate(date: currRecipe.dateEntry)
            cell.userNickName.text = "@\(currRecipe.owner!.nickName)"
            cell.userName.text = currRecipe.owner?.name
            cell.recipeName.text = currRecipe.name
            cell.recipeImage.image = currRecipe.image
            cell.recipeBriefDescription.text = currRecipe.description
        
            return cell
        }
        return UITableViewCell()
    }
    
        
    // INITAL SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trendingCollectionView.reloadData()
        recipeTableView.reloadData()
    }
    
    
    // OTHER FUNCTIONS
    // Returns a concise string corresponding to time since post
    func formatDate(date: Date) -> String {
        // returns a concise string corresponding to time since post
        let minutesAgo =  -Int((date.timeIntervalSinceNow / 60))
        return "\(minutesAgo) minutes ago"
    }
}
