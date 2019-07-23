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
                                                                            UIImage(named: "StanFoto6")]),
        Friend(name: "Apu", surname: "Nahasapeemapetilon", avatar: UIImage(named: "Apu"), photos: [UIImage(named: "ApuFoto1"),
                                                                                                   UIImage(named: "ApuFoto2"),
                                                                                                   UIImage(named: "ApuFoto3")]),
        Friend(name: "Barney", surname: "Gumble", avatar: UIImage(named: "Barney"), photos: [UIImage(named: "BarneyFoto1"),
                                                                                        UIImage(named: "BarneyFoto2"),
                                                                                        UIImage(named: "BarneyFoto3"),
                                                                                        UIImage(named: "BarneyFoto4")]),
        Friend(name: "Joe", surname: "Quimby", avatar: UIImage(named: "Joe"), photos: [UIImage(named: "JoeFoto1"),
                                                                                           UIImage(named: "JoeFoto2"),
                                                                                           UIImage(named: "JoeFoto3"),
                                                                                           UIImage(named: "JoeFoto4")]),
        Friend(name: "Cletus", surname: "Spuckler", avatar: UIImage(named: "Cletus"), photos: [UIImage(named: "CletusFoto1"),
                                                                                           UIImage(named: "CletusFoto2"),
                                                                                           UIImage(named: "CletusFoto3")]),
        Friend(name: "Moe", surname: "Szyslak", avatar: UIImage(named: "Moe"), photos: [UIImage(named: "MoeFoto2"),
                                                                                           UIImage(named: "MoeFoto3")]),
        Friend(name: "Ned", surname: "Flanders", avatar: UIImage(named: "Ned"), photos: [UIImage(named: "NedFoto1"),
                                                                                           UIImage(named: "NedFoto2"),
                                                                                           UIImage(named: "NedFoto3"),
                                                                                           UIImage(named: "NedFoto4"),
                                                                                           UIImage(named: "NedFoto5")]),
        Friend(name: "Lurleen", surname: "Lumpkin", avatar: UIImage(named: "Lurleen"), photos: [UIImage(named: "LurleenFoto1"),
                                                                                           UIImage(named: "LurleenFoto2"),
                                                                                           UIImage(named: "LurleenFoto3"),
                                                                                           UIImage(named: "LurleenFoto4")]),
        Friend(name: "Marge", surname: "Simpson", avatar: UIImage(named: "Marge"), photos: [UIImage(named: "MargeFoto1"),
                                                                                           UIImage(named: "MargeFoto2"),
                                                                                           UIImage(named: "MargeFoto3"),
                                                                                           UIImage(named: "MargeFoto4"),
                                                                                           UIImage(named: "MargeFoto5"),
                                                                                           UIImage(named: "MargeFoto6"),
                                                                                           UIImage(named: "MargeFoto7"),
                                                                                           UIImage(named: "MargeFoto8"),
                                                                                           UIImage(named: "MargeFoto9"),
                                                                                           UIImage(named: "MargeFoto10")]),
        Friend(name: "Patty", surname: "Bouvier", avatar: UIImage(named: "Patty"), photos: [UIImage(named: "PattyFoto1"),
                                                                                           UIImage(named: "PattyFoto2")]),
        Friend(name: "Edna", surname: "Krabappel", avatar: UIImage(named: "Edna"), photos: [UIImage(named: "EdnaFoto1"),
                                                                                           UIImage(named: "EdnaFoto2"),
                                                                                           UIImage(named: "EdnaFoto3")])
    ]
    
    var firstCharacter = [Character]()
    var sortedFriends: [Character: [Friend]] = [:]
    
    
    @IBOutlet var friendsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (firstCharacter, sortedFriends) = sort(friends)
        
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
            friendCell.friendAvatarView.image = friends[indexPath.row].avatar
            return friendCell
        }
        
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = GradientView()
        header.startColor = .lightGray
        header.endColor = .clear
        header.startPoint = .zero
        header.endPoint = CGPoint(x: 1, y: 0.1)
        header.startLocation = 0
        header.endLocation = 0.3
        
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
    private func sort(_: [Friend]) -> (characters: [Character], sortedFriends: [Character: [Friend]]){
        
        var characters = [Character]()
        var sortedFriends = [Character: [Friend]]()
        
        friends.forEach { friend in
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
        if segue.identifier == "FriendsFotoSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? FriendPhotoController
        {
            let character = firstCharacter[indexPath.section]
            if let friends = sortedFriends[character] {
                let friend = friends[indexPath.row]
                let photos = friend.photos
                photoVC.photos = photos as! [UIImage]
            }
        }
    }
}
