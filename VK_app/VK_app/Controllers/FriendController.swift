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
    var filteredFriends: Results<Friend>?
    private var notificationToken: NotificationToken?
    
    @IBOutlet var friendsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "logOutSegue", sender: self)
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkServiceProxy = NetworkServiceProxy(networkService: NetworkService())
        let promise = networkServiceProxy.getFriends()
        
        promise
            .done { friends in
                try? RealmService.saveData(objects: friends)
            } .catch { error in
                self.show(error)
            }
        
        searchBar.delegate = self
        
        let friends = try? RealmService.getData(type: Friend.self)
        self.notificationToken = friends?.observe { [weak self] change in
            guard let friends = friends,
                let self = self else { return }
            switch change {
            case .initial, .update:
                (self.firstCharacter, self.sortedFriends) = self.sort(friends)
                self.tableView.reloadData()
            case .error(let error):
                self.show(error)
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseID, for: indexPath) as! FriendCell
        
        let character = firstCharacter[indexPath.section]
        if let friends = sortedFriends[character] {
            let friend = friends[indexPath.row]
            cell.configure(with: friend)
        
            cell.indexPath = indexPath
            cell.delegate = self
            cell.friendNameLabel.backgroundColor = self.friendsTable.backgroundColor
            cell.friendAvatarView.backgroundColor = self.friendsTable.backgroundColor
        
            return cell
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

    //MARK: - UISearchBar method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchActive = false
        } else {
            searchActive = true
        }
        
        let friends = try? RealmService.getData(type: Friend.self)
        filteredFriends = friends?.filter("name CONTAINS[cd] %@ OR surname CONTAINS[cd] %@", searchText, searchText)
        (self.firstCharacter, self.sortedFriends) = self.sort(filteredFriends!.self)
        tableView.reloadData()
    }
    
    /// Sorts friends + first letters
    ///
    /// - Parameter friends: input friends
    /// - Returns: tuple with characters & friends
    private func sort(_: Results<Friend>) -> (characters: [Character], sortedFriends: [Character: [Friend]]){
    
        var characters = [Character]()
        var sortedFriends = [Character: [Friend]]()
        
        if searchActive {
            filteredFriends!.forEach { friend in
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
