//
//  FeedData.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import Foundation
import UIKit

var feed = FeedData()

class User {
    var login: LoginInfo
    var image: UIImage
    var name: String
    var nickName: String
    var dateEntry: Date
    var followers: [User]
    var followed: [User]
    var userRecipes: [Recipe]
    var email: String
    
    init(name: String, image: UIImage, user: String, pass: String, email: String) {
        self.login = LoginInfo(username: user, password: pass)
        self.image = image
        self.nickName = user
        self.name = name
        self.dateEntry = Date()
        self.followers = []
        self.followed = []
        self.userRecipes = []
        self.email = email
    }
    
    func addRecipe(recipe: Recipe) {
        userRecipes.append(recipe)
        recipe.setOwner(user: self)
    }
    
    func addFollower(user: User) {
        self.followers.append(user)
    }
    
    func addFollowed(user: User) {
        self.followed.append(user)
    }
    
    func getFollowersCount() -> Int {
        return self.followers.count
    }
    
    func getRecipesCount() -> Int {
        return self.userRecipes.count
    }
    
    
    func getFollowedCount() -> Int {
        return self.followed.count
    }
    
    func getYearEntry() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: dateEntry)
        return components.year!
    }
    
    func removeRecipe(index: Int) -> Recipe? {
        if userRecipes.count > 0 {
            return userRecipes.remove(at: index)
        }
        return nil
    }
    
    static func ==(right: User, left: User) -> Bool {
        return right.name == left.name && right.email == left.email
    }
}

struct LoginInfo {
    var username: String
    var password: String
}

class Recipe {
    var image: UIImage
    var name: String
    var description: String
    var servings: Int
    var prepTime: Int
    var cookTime: Int
    var dateEntry: Date
    var ingredients: String
    var instructions: String
    var notes: String
    var liked: [User]
    var owner: User?
    
    init(name: String, description: String, servings: Int, prepTime: Int, cookTime: Int, ingredients: String, instructions: String, notes: String, image: UIImage) {
        self.image = image
        self.name = name
        self.description = description
        self.servings = servings
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.dateEntry = Date()
        self.ingredients = ingredients
        self.instructions = instructions
        self.notes = notes
        self.liked = []
        owner = nil
    }
    
    func setOwner(user: User) {
        self.owner = user
    }
    
    func getLikes() -> Int {
        return self.liked.count
    }
    
}

class FeedData {
    var curr: User
    var users: [User]
    var recipes: [Recipe] = []
    func addUser(user: User) {
        users.append(user)
    }
    
    func getCurrUser() -> User? {
        if (firebaseManager.signedIn()) {
            return getCurrUserFrom(email: firebaseManager.getCurrUserEmail())!
        }
        return guest
    }
    
    func getCurrUserFrom(email: String) -> User? {
        for user in users {
            if user.email == email {
                return user
            }
        }
        return nil
    }
    
    func addRecipe(recipe: Recipe, user: User){
        recipes.append(recipe)
        user.addRecipe(recipe: recipe)
    }
    
    func sortRecipeFollowing(method: String) -> [Recipe]{
        var sortedRecipes: [Recipe] = recipes
        sortedRecipes = recipes
        switch method {
        case "trending": // Sorted by likedCount
            return sortedRecipes.sorted(by: { $0.getLikes() > $1.getLikes()})
        case "recently": // Sorted by timestamp
            return sortedRecipes.sorted(by: { $0.dateEntry > $1.dateEntry})
        case "user":
            return sortRecipeFollowing(user: tramnguyen)
        default:
            return sortedRecipes
        }
    }
    
    func sortRecipeFollowing(user: User) -> [Recipe]{
        var sortedRecipes: [Recipe] = []
        // Sorted by user and timestamp
        for recipe in recipes {
            if (recipe.owner?.name == user.name) {
                sortedRecipes.append(recipe)
            }
        }
        return sortedRecipes.sorted(by: { $0.dateEntry > $1.dateEntry})
    }
    
    // Returns a concise string corresponding to time since post
    func formatDate(date: Date) -> String {
        let secondsAgo = Int(Date().timeIntervalSince(date))
    
            let minute = 60
            let hour = 60 * minute
            let day = 24 * hour
            let week = 7 * day
            let month = 4 * week
            let year = 12 * month

        
            let quotient: Int
            let unit: String
            if secondsAgo < hour {
                quotient = secondsAgo / minute
                unit = "min"
            } else if secondsAgo < day {
                quotient = secondsAgo / hour
                unit = "hour"
            } else if secondsAgo < week {
                quotient = secondsAgo / day
                unit = "day"
            } else if secondsAgo < month {
                quotient = secondsAgo / week
                unit = "week"
            } else if secondsAgo < year{
                quotient = secondsAgo / month
                unit = "month"
            } else {
                quotient = secondsAgo / year
                unit = "year"
            }
            return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
    
    // DUMMY DATA
    init() {
        // Initialize dummy data
        recipe2.liked = [anton, guest]
        
        tramnguyen.addRecipe(recipe: recipe3) // "Crispy Spring Rolls"3
        anton.addRecipe(recipe: recipe2) // "Crispy Chicken Wings"2
        tramnguyen.addRecipe(recipe: recipe1) //"Chinnese Hotpot",1
        
        self.curr = guest
        self.users = [guest, tramnguyen, anton]
        for user in users {
            let userRecipe = user.userRecipes
            recipes.append(contentsOf: userRecipe)
        }
    }
    
    var guest: User = User(
        name: "Guest",
        image: UIImage(named: "chef")!,
        user: "guest",
        pass: "guestnenha",
        email: "guest.email.com"
    )
    
    var tramnguyen: User = User(
        name: "Tram Nguyen",
        image: UIImage(named: "Screen Shot 2020-04-16 at 12.17.11 AM")!,
        user: "tramn",
        pass: "tramnenha",
        email: "tramn@berkeley.edu"
    )

    var anton: User = User(
        name: "An Ton",
        image: UIImage(named: "80670243_2591624214401817_6146746027673124864_n")!,
        user: "anton",
        pass: "antonnenha",
        email: "aton18@berkeley.edu"
    )

    var recipe1: Recipe = Recipe(
        name: "Chinnese Hotpot",
        description: "A simmering pot of soup stock containing a variety of foodstuffs and ingredients.",
        servings: 2,
        prepTime: 60,
        cookTime: 20,
        ingredients: "Testing",
        instructions: "Testing",
        notes: "Testing",
        image: UIImage(named: "l-u-coca-ngon-tr-danh")!
    )

    var recipe2: Recipe = Recipe(
        name: "Crispy Chicken Wings",
        description: "These Crispy Buffalo Chicken Wings are exactly what they claim to be. C.R.I.S.P.Y. ",
        servings: 2,
        prepTime: 25,
        cookTime: 20,
        ingredients: "Testing",
        instructions: "Toss chicken wings until they are coated evenly. After your chicken wings are coated, place aluminium foil on your baking sheet to catch any drippings, then arrange a wire rack over the top. Place your wings in an even layer to allow the heat to be evenly distributed.",
        notes: "Chicken wings can take about 50 minutes or more to bake, flipping them halfway through cooking time to allow even crispness",
        image: UIImage(named: "baked-chicken-wings")!
    )
    
    var recipe3: Recipe = Recipe(
        name: "Crispy Spring Rolls",
        description: "The rolls are  light with crisp-crackly skin and small enough to enjoy in 4 bites.  ",
        servings: 2,
        prepTime: 25,
        cookTime: 20,
        ingredients: "Testing",
        instructions: "Toss chicken wings until they are coated evenly. After your chicken wings are coated, place aluminium foil on your baking sheet to catch any drippings, then arrange a wire rack over the top. Place your wings in an even layer to allow the heat to be evenly distributed.",
        notes: "N/A",
        image: UIImage(named: "bun-cha-gio1-300x199")!
    )
}




