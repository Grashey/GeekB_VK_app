//
//  FriendsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendController: UITableViewController {
    
    let friends = [
        Friend(name: "Bart", surname: "Simpson", avatar: UIImage(named: "Bart"), photos: [UIImage(named: "BartFoto1"),
                                                                              UIImage(named: "BartFoto2")]),
        Friend(name: "Butters", surname: "Stotch", avatar: UIImage(named: "Butters"), photos: [UIImage(named: "ButtersFoto1")]),
        Friend(name: "Eric", surname: "Cartman", avatar: UIImage(named: "Cartman"), photos: [UIImage(named: "CartmanFoto1"),
                                                                                 UIImage(named: "CartmanFoto2"),
                                                                                 UIImage(named: "CartmanFoto3"),
                                                                                 UIImage(named: "CartmanFoto4")]),
        Friend(name: "Homer", surname: "Simpson", avatar: UIImage(named: "Homer"), photos: [UIImage(named: "HomerFoto1"),
                                                                                UIImage(named: "HomerFoto2"),
                                                                                UIImage(named: "HomerFoto3")]),
        Friend(name: "Kenny", surname: "McCormick", avatar: UIImage(named: "Kenny"), photos: [UIImage(named: "KennyFoto1"),
                                                                                  UIImage(named: "KennyFoto2"),
                                                                                  UIImage(named: "KennyFoto3"),
                                                                                  UIImage(named: "KennyFoto4")]),
        Friend(name: "Kyle", surname: "Broflovski", avatar: UIImage(named: "Kyle"), photos: [UIImage(named: "KyleFoto1"),
                                                                                 UIImage(named: "KyleFoto2"),
                                                                                 UIImage(named: "KyleFoto3"),
                                                                                 UIImage(named: "KyleFoto4")]),
        Friend(name: "Stan", surname: "Marsh", avatar: UIImage(named: "Stan"), photos: [UIImage(named: "StanFoto1"),
                                                                            UIImage(named: "StanFoto2"),
                                                                            UIImage(named: "StanFoto3"),
                                                                            UIImage(named: "StanFoto4"),
                                                                            UIImage(named: "StanFoto5"),
                                                                            UIImage(named: "StanFoto6")])
    ]
    
    @IBOutlet var friendsTable: UITableView!
    
    //MARK: - UITableViewDataSource methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sortedFriends = friends.sorted(by: { $0.surname < $1.surname })
        
        let friendCell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        friendCell.friendNameLabel.text = sortedFriends[indexPath.row].name + " " + sortedFriends[indexPath.row].surname
        friendCell.friendAvatarView.image = sortedFriends[indexPath.row].avatar
        
        return friendCell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsFotoSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? FriendPhotoController
        {
            let sortedFriends = friends.sorted(by: { $0.surname < $1.surname })
            let friend = sortedFriends[indexPath.row]
            let photo = friend.photos
            photoVC.photos = photo as! [UIImage]
        }
    }
}
