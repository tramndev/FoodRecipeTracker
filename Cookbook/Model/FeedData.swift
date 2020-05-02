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
    var friendList: [User]
    var userRecipes: [Recipe]
    var email: String
    var friendRequestSents: [User]
    var unresolvedRequests: [User]
    var unresolvedLikes: [Like]
    
    init(name: String, image: UIImage, user: String, pass: String, email: String) {
        self.login = LoginInfo(username: user, password: pass)
        self.image = image
        self.nickName = user
        self.name = name
        self.dateEntry = Date()
        self.friendList = []
        self.userRecipes = []
        self.email = email
        self.unresolvedLikes = []
        self.unresolvedRequests = []
        self.friendRequestSents = []
    }
    
    func addRecipe(recipe: Recipe) {
        userRecipes.append(recipe)
        recipe.setOwner(user: self)
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
    
    func beFriend(user: User) -> Bool {
        for friend in friendList {
            if friend == user {
                return true
            }
        }
        return false
    }
    
    static func ==(right: User, left: User) -> Bool {
        return right.name == left.name && right.email == left.email
    }
    
    //new add
    static func !=(right: User, left: User) -> Bool {
        return right.name != left.name || right.email != left.email
    }
    
    //new add
    func getRequests() -> [User] {
        return unresolvedRequests
    }
    
    //new add
    func getLikes() -> [Like] {
        return unresolvedLikes
    }
    
    //new add
    func resolveRequest(user: User) {
        unresolvedRequests = unresolvedRequests.filter({$0 != user})
    }
    
    //new add
    func resolveLike(user: User) {
        unresolvedLikes = unresolvedLikes.filter({$0.user != user})
    }
    
    //new add
    func beLiked(byUser: User, theRecipe: Recipe) {
        unresolvedLikes.append(Like(user: byUser, recipe: theRecipe))
    }
    
    func sendFriendRequest(user: User) {
        user.unresolvedRequests.append(self)
        friendRequestSents.append(self)
    }
    
    func addFriend(user: User) {
        friendList.append(user)
        user.friendList.append(self)
        resolveRequest(user: user)
        user.friendRequestSents = user.friendRequestSents.filter({$0 != self})
    }
    
    func requestSent(user: User) ->Bool {
        for friend in friendRequestSents {
            if friend === user {
                return true
            }
        }
        return false
    }
    
    func ignoreFriendRequest(user: User) {
        resolveRequest(user: user)
    }
}

struct LoginInfo {
    var username: String
    var password: String
}

struct Like {
    var user: User
    var recipe: Recipe
    var timeStamp: Date = Date()
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
    
    func isLikedBy(user: User) -> Bool {
        for u in liked {
            if u === user {
                return true
            }
        }
        return false
    }
    
    func setDateEntry(date: Date) {
        dateEntry = date
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
    
    func getRecipe(recipeName: String) -> Recipe? {
        for recipe in recipes {
            if recipe.name == recipeName {
                return recipe
            }
        }
        return nil
    }
    
    func getUser(image: UIImage) -> User? {
        for user in users {
            if user.image == image {
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
        recipe1.setDateEntry(date: Date(timeIntervalSinceNow: -1600))
        recipe2.setDateEntry(date: Date(timeIntervalSinceNow: -16000))
        recipe3.setDateEntry(date: Date(timeIntervalSinceNow: -800))
        
        tramnguyen.addRecipe(recipe: recipe3) // "Crispy Spring Rolls"3
        anton.addRecipe(recipe: recipe2) // "Crispy Chicken Wings"2
        tramnguyen.addRecipe(recipe: recipe1) //"Chinnese Hotpot",1
        tramnguyen.addRecipe(recipe: recipe4) //"Pho",1
        
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
        pass: "helloworld",
        email: "tramn@berkeley.edu"
    )

    var anton: User = User(
        name: "An Ton",
        image: UIImage(named: "80670243_2591624214401817_6146746027673124864_n")!,
        user: "anton",
        pass: "helloworld",
        email: "aton18@berkeley.edu"
    )

    var recipe1: Recipe = Recipe(
        name: "Chinnese Hotpot",
        description: "A simmering pot of soup stock containing a variety of foodstuffs and ingredients.",
        servings: 2,
        prepTime: 60,
        cookTime: 20,
        ingredients: "Chicken stock,Bean thread noodles, Green onions, Rice vinegar",
        instructions: "Bring the chicken stock, water, rice vinegar, soy sauce, sesame oil, minced ginger and cracked garlic to a low boil in a large soup pot. Add the thinly sliced chicken thighs and simmer for 5-7 minutes.Add the gluten free bean thread or rice noodles. Stir, then cover and remove from heat.",
        notes: "Add the gluten free bean thread or rice noodles ladle the scalding hot soup over the veggies and let them sit for 5 minutes before enjoying",
        image: UIImage(named: "l-u-coca-ngon-tr-danh")!
    )

    var recipe2: Recipe = Recipe(
        name: "Crispy Chicken Wings",
        description: "These Crispy Buffalo Chicken Wings are exactly what they claim to be. C.R.I.S.P.Y. ",
        servings: 2,
        prepTime: 25,
        cookTime: 20,
        ingredients: "Chicken wings, baking powder, salt, garlic powder, cracked pepper",
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
        ingredients: "Shredded cabbage, Pork, oyster sauce, salt, pepper, sesame oil",
        instructions: "Assemble and wrap the rolls with the wrappers. Use thin wrapper to make crispy rolls. For the best flavors, use pork and shrimp with shredded cabbage in the filling.The final step is deep frying. Serve warm with your favorite dipping sauce.",
        notes: "For authentic flavors, serve without the dipping sauce. If you like, you may serve with a mild chili-garlic sauce or sweet chili sauce.",
        image: UIImage(named: "bun-cha-gio1-300x199")!
    )
    
    var recipe4: Recipe = Recipe(
        name: "Authetic Pho",
        description: "Chewy noodles, nourishing bone broth, fresh vegetables, and tender slices of meat make this easy and delicious.",
        servings: 2,
        prepTime: 60,
        cookTime: 60,
        ingredients: "Bone, raw meat, spices, onion, garlic, ginger, noodles, garnishes",
        instructions: "Blanch the bones, then roast the bones and the vegetables, toast the spices. Boil and strim the bones. Add more water if needed to make sure the bones stay submerged.The broth needs to cook for at least 2 hours. Leave the remaining chuck and bones to simmer in the pot while you assemble the bowls.",
        notes: "To serve, place the cooked noodles in preheated bowls.",
        image: UIImage(named: "1567085928842-1")!
    )
}




