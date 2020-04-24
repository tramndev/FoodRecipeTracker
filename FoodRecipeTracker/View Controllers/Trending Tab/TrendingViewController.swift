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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
    }
    
    // TRENDING TABLE VIEW SETUP
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.recipes.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTableView", for: indexPath) as? TrendingTableViewCell {
            
            // configure TrendingTableCell
            let recieps = feed.sortRecipeFollowing(method: "trending")
            let currRecipe = recieps[indexPath.row]
            
            cell.userImage.image = currRecipe.owner?.image
            cell.recipeTimeStamp.text = formatDate(date: currRecipe.dateEntry)
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
