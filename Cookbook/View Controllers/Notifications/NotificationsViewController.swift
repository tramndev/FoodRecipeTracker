//
//  NotificationsViewController.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/23/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var requests = feed.getCurrUser()?.getRequests()
    var likes = feed.getCurrUser()?.getLikes()
    
    @IBOutlet weak var friendRequestTableView: UITableView!

    @IBOutlet weak var notificationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        friendRequestTableView.delegate = self
        friendRequestTableView.dataSource = self
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        friendRequestTableView.reloadData()
        notificationsTableView.reloadData()
    }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if tableView == friendRequestTableView {
        return 70
    } else if tableView == notificationsTableView {
        return 70
    }
    return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == friendRequestTableView, let r = requests {
            return r.count
        } else if tableView == notificationsTableView, let l = likes {
            return l.count
        }
        return 0
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == friendRequestTableView, let cell = tableView.dequeueReusableCell(withIdentifier: "friendRequestTableViewCell", for: indexPath) as? FriendRequestTableViewCell {
            // configure TrendingTableCell
            if let r = requests {
                let user = r[indexPath.row]

                cell.friendImage.image = user.image
                cell.friendRequestMessage.text = "\(user.name) sent you a friend request"
                
                // Config for cell protocol funcs
                cell.delegate = self
            }
            return cell
        } else if tableView == notificationsTableView, let cell = tableView.dequeueReusableCell(withIdentifier: "notifications", for: indexPath) as? NotificationsTableViewCell {
            if let l = likes?.sorted(by: { $0.timeStamp > $1.timeStamp}) {
                let user = l[indexPath.row].user
                let recipe = l[indexPath.row].recipe
                let timeStamp = l[indexPath.row].timeStamp
                
                cell.timeStamp.text = feed.formatDate(date: timeStamp)
                cell.friendImage.image = user.image
                cell.notiMessage.text = "\(user.name) likes your \(recipe.name)."
            }
            return cell
        }
        return UITableViewCell()
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == friendRequestTableView, let r = requests {
            let chosenUser = r[indexPath.item]
            performSegue(withIdentifier: "showUser", sender: chosenUser)
        }
        else if tableView == notificationsTableView, let l = likes {
            let chosenRecipe = l[indexPath.item].recipe
            performSegue(withIdentifier: "showRecipe", sender: chosenRecipe)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UserRecipeViewController, let chosenUser = sender as? User {
                dest.guestUser = chosenUser
        } else if let dest = segue.destination as? RecipeViewController, let chosenRecipe = sender as? Recipe {
                dest.chosenRecipe = chosenRecipe
            } else if let dest = segue.destination as? TabBarViewController, let index = sender as? Int  {
                dest.index = index
            }
    }
    
}

extension NotificationsViewController: FriendRequestTableViewCellDelegate {
    func didTapConfirmAddFriend(user: User) {
        feed.getCurrUser()?.addFriend(user: user)
        self.viewWillAppear(true)
    }
    
    func didTapIgnoreFriendRequest(user: User) {
        feed.getCurrUser()?.ignoreFriendRequest(user: user)
        self.viewWillAppear(true)
        performSegue(withIdentifier: "goBack", sender: 2)
    }
}
