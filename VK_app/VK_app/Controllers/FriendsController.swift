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
        Friend(name: "Bart", avatar: nil),
        Friend(name: "Butters", avatar: nil),
        Friend(name: "Cartman", avatar: nil),
        Friend(name: "Homer", avatar: nil),
        Friend(name: "Kenny", avatar: nil),
        Friend(name: "Kyle", avatar: nil),
        Friend(name: "Stan", avatar: nil),]
    

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
        return friendCell
        
    }
}
