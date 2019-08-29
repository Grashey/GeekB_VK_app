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

class FriendController: UITableViewController, FriendCellDelegate {
    
    var firstCharacter = [Character]()
    var sortedFriends: [Character: [Friend]] = [:]
    
    @IBOutlet var friendsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getFriends() { [weak self] friend in
            guard let self = self else { return }
            
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true, objectTypes: [Friend.self])
            print(configuration.fileURL ?? Error.self)
            
            do {
                let realm = try Realm(configuration: configuration)
                try realm.write {
                    realm.add(friend, update: .all)
                }
            } catch {
                print(Error.self)
            }
            do {
                let realm = try Realm()
                let friends = realm.objects(Friend.self)
                (self.firstCharacter, self.sortedFriends) = self.sort(friends.self)
                self.friendsTable.reloadData()
            } catch {
                print(Error.self)
            }
        }
    }
    
    //MARK: - UITableViewDataSource methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstCharacter.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let character = firstCharacter[section]
        let friendsCount = sortedFriends[character]?.count
        
        return friendsCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friendCell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        let character = firstCharacter[indexPath.section]
        if let friends = sortedFriends[character] {
            friendCell.friendNameLabel.text = friends[indexPath.row].name + " " + friends[indexPath.row].surname
            
            let imageUrl = URL(string: friends[indexPath.row].avatar)
            friendCell.friendAvatarView.kf.setImage(with: imageUrl)
            
            friendCell.indexPath = indexPath
            friendCell.delegate = self
          
            return friendCell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = GradientView()
        header.startColor = UIColor(white: 1, alpha: 0.5)
        header.endColor = .clear
        header.startPoint = .zero
        header.endPoint = CGPoint(x: 1, y: 0.1)
        header.startLocation = 0
        header.endLocation = 0.2
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = String(firstCharacter[section])
        header.addSubview(label)
        
        return header
    }
    
    /// Sorts friends + first letters
    ///
    /// - Parameter friends: input friends
    /// - Returns: tuple with characters & friends
    private func sort(_: Results<Friend>) -> (characters: [Character], sortedFriends: [Character: [Friend]]){
        
        var characters = [Character]()
        var sortedFriends = [Character: [Friend]]()
        let realm = try? Realm()
        let friends = realm?.objects(Friend.self)
        
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
        characters.sort()
        
        return (characters, sortedFriends)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendPhotoSegue",
            let photoVC = segue.destination as? FriendPhotoController,
            let indexPath = tableView.indexPathForSelectedRow ?? sender as! IndexPath?
        {
            let character = firstCharacter[indexPath.section]
            if let friends = sortedFriends[character] {
                let friend = friends[indexPath.row]
                photoVC.friendId = friend.id
            }
        }
    }
    func performSegueFromView(sender: IndexPath) {
        self.performSegue(withIdentifier: "FriendPhotoSegue", sender: sender)
    }
}
