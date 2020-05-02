//
//  FriendRequestTableViewCell.swift
//  FoodRecipeTracker
//
//  Created by Tram Nguyen on 4/22/20.
//  Copyright © 2020 Tram Nguyen. All rights reserved.
//

import UIKit

protocol FriendRequestTableViewCellDelegate {
    func didTapConfirmAddFriend(user: User)
    func didTapIgnoreFriendRequest(user: User)
}
class FriendRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendRequestMessage: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: FriendRequestTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        delegate?.didTapConfirmAddFriend(user: feed.getUser(image: friendImage.image!)!)
        confirmButton.setTitle("Friend ✓", for: .normal)
        deleteButton.isHidden = true
        deleteButton.isEnabled = false
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        delegate?.didTapIgnoreFriendRequest(user: feed.getUser(image: friendImage.image!)!)
    }
    
}
