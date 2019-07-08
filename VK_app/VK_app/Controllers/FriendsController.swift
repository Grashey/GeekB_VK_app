//
//  FriendsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    fileprivate let friends = [
        Friend(name: "Bart Simpson", avatar: UIImage(named: "Bart")),
        Friend(name: "Butters Stotch", avatar: UIImage(named: "Butters")),
        Friend(name: "Eric Cartman", avatar: UIImage(named: "Cartman")),
        Friend(name: "Homer Simpson", avatar: UIImage(named: "Homer")),
        Friend(name: "Kenny McCormick", avatar: UIImage(named: "Kenny")),
        Friend(name: "Kyle Broflovski", avatar: UIImage(named: "Kyle")),
        Friend(name: "Stan Marsh", avatar: UIImage(named: "Stan")),]
    

    @IBOutlet var friendsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friendCell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        friendCell.friendNameLabel.text = friends[indexPath.row].name
        if friends[indexPath.row].avatar == nil {
           friendCell.friendAvatarView.image = UIImage(named: "defaultAva")
        } else {
            friendCell.friendAvatarView.image = friends[indexPath.row].avatar
        }
        return friendCell
        
    }
}
