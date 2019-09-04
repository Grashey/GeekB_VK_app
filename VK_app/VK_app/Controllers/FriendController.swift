//
//  FriendsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendController: UITableViewController, FriendCellDelegate, UISearchBarDelegate {
    
    var firstCharacter = [Character]()
    var sortedFriends: [Character: [Friend]] = [:]
    var searchActive : Bool = false
    var filteredFriends: [Friend] = []
    
    @IBOutlet var friendsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getFriends() { [weak self] friend in
            guard let self = self else { return }
            try? RealmService.saveData(objects: friend)
            let friends = try? RealmService.getData(type: Friend.self)
            (self.firstCharacter, self.sortedFriends) = self.sort((friends.self)!)
            self.friendsTable.reloadData()
        }
        
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstCharacter.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if(searchActive) {
//            return filteredFriends.count
//        } else {
//            let friends = try? RealmService.getData(type: Friend.self)
//            return friends?.count ?? 0
//        }
        
        let character = firstCharacter[section]
        let friendsCount = sortedFriends[character]?.count
        
        return friendsCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friendCell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        if(searchActive){
            friendCell.friendNameLabel.text = filteredFriends[indexPath.row].name + " " + filteredFriends[indexPath.row].surname
            
            let imageUrl = URL(string: filteredFriends[indexPath.row].avatar)
            friendCell.friendAvatarView.kf.setImage(with: imageUrl)
        } else {
            let friends = try? RealmService.getData(type: Friend.self)
            
            friendCell.friendNameLabel.text = (friends?[indexPath.row].name)! + " " + (friends?[indexPath.row].surname)!
            
            let imageUrl = URL(string: friends?[indexPath.row].avatar ?? "")
            friendCell.friendAvatarView.kf.setImage(with: imageUrl)
        }
        
        friendCell.indexPath = indexPath
        friendCell.delegate = self
        
        return friendCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(searchActive){
                filteredFriends.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                filteredFriends.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    //MARK: - UISearchBar method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let friends = try? RealmService.getData(type: Friend.self)
        filteredFriends = (friends?.filter ({ (friend) -> Bool in
            let tmp: NSString = friend.name as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        }))!
        if searchText.isEmpty {
            searchActive = false
        } else {
            searchActive = true
        }
        tableView.reloadData()
    }
    
    /// Sorts friends + first letters
    ///
    /// - Parameter friends: input friends
    /// - Returns: tuple with characters & friends
    private func sort(_: Results<Friend>) -> (characters: [Character], sortedFriends: [Character: [Friend]]){
    
        var characters = [Character]()
        var sortedFriends = [Character: [Friend]]()
        
        if(searchActive){
            filteredFriends.forEach { friend in
                guard let character = friend.surname.first else { return }
                if var thisCharFriends = sortedFriends[character] {
                    thisCharFriends.append(friend)
                    let sortedCharFriends = thisCharFriends.sorted(by: {$0.surname < $1.surname})
                    sortedFriends[character] = sortedCharFriends
                } else {
                    sortedFriends[character] = [friend]
                    characters.append(character)
                }
            }
        } else {
            let friends = try? RealmService.getData(type: Friend.self)
            friends?.forEach { friend in
                guard let character = friend.surname.first else { return }
                if var thisCharFriends = sortedFriends[character] {
                    thisCharFriends.append(friend)
                    let sortedCharFriends = thisCharFriends.sorted(by: {$0.surname < $1.surname})
                    sortedFriends[character] = sortedCharFriends
                } else {
                    sortedFriends[character] = [friend]
                    characters.append(character)
                }
            }
        }
        characters.sort()
        return (characters, sortedFriends)
    }
    
    func performSegueFromView(sender: IndexPath) {
        self.performSegue(withIdentifier: "FriendPhotoSegue", sender: sender)
    }
}
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let networkService = NetworkService()
//        networkService.getFriends() { [weak self] friend in
//            guard let self = self else { return }
//            try? RealmService.saveData(objects: friend)
//            let friends = try? RealmService.getData(type: Friend.self)
//            (self.firstCharacter, self.sortedFriends) = self.sort((friends.self)!)
//            self.friendsTable.reloadData()
//        }
//    }
//
//    //MARK: - UITableViewDataSource methods
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return firstCharacter.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        let character = firstCharacter[section]
//        let friendsCount = sortedFriends[character]?.count
//
//        return friendsCount ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let friendCell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
//
//        let character = firstCharacter[indexPath.section]
//        if let friends = sortedFriends[character] {
//            friendCell.friendNameLabel.text = friends[indexPath.row].name + " " + friends[indexPath.row].surname
//
//            let imageUrl = URL(string: friends[indexPath.row].avatar)
//            friendCell.friendAvatarView.kf.setImage(with: imageUrl)
//
//            friendCell.indexPath = indexPath
//            friendCell.delegate = self
//
//            return friendCell
//        }
//        return UITableViewCell()
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let header = GradientView()
//        header.startColor = UIColor(white: 1, alpha: 0.5)
//        header.endColor = .clear
//        header.startPoint = .zero
//        header.endPoint = CGPoint(x: 1, y: 0.1)
//        header.startLocation = 0
//        header.endLocation = 0.2
//
//        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.text = String(firstCharacter[section])
//        header.addSubview(label)
//
//        return header
//    }
//
//    /// Sorts friends + first letters
//    ///
//    /// - Parameter friends: input friends
//    /// - Returns: tuple with characters & friends
//    private func sort(_: Results<Friend>) -> (characters: [Character], sortedFriends: [Character: [Friend]]){
//
//        var characters = [Character]()
//        var sortedFriends = [Character: [Friend]]()
//        let friends = try? RealmService.getData(type: Friend.self)
//
//        friends?.forEach { friend in
//            guard let character = friend.surname.first else { return }
//            if var thisCharFriends = sortedFriends[character] {
//                thisCharFriends.append(friend)
//                let sortedCharFriends = thisCharFriends.sorted(by: {$0.surname < $1.surname})
//                sortedFriends[character] = sortedCharFriends
//            } else {
//                sortedFriends[character] = [friend]
//                characters.append(character)
//            }
//        }
//        characters.sort()
//
//        return (characters, sortedFriends)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "FriendPhotoSegue",
//            let photoVC = segue.destination as? FriendPhotoController,
//            let indexPath = tableView.indexPathForSelectedRow ?? sender as! IndexPath?
//        {
//            let character = firstCharacter[indexPath.section]
//            if let friends = sortedFriends[character] {
//                let friend = friends[indexPath.row]
//                photoVC.friendId = friend.id
//            }
//        }
//    }
//    func performSegueFromView(sender: IndexPath) {
//        self.performSegue(withIdentifier: "FriendPhotoSegue", sender: sender)
//    }
//}
