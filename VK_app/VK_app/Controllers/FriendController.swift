//
//  FriendsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    let friends = [
        Friend(name: "Bart Simpson", avatar: UIImage(named: "Bart")),
        Friend(name: "Butters Stotch", avatar: UIImage(named: "Butters")),
        Friend(name: "Eric Cartman", avatar: UIImage(named: "Cartman")),
        Friend(name: "Homer Simpson", avatar: UIImage(named: "Homer")),
        Friend(name: "Kenny McCormick", avatar: UIImage(named: "Kenny")),
        Friend(name: "Kyle Broflovski", avatar: UIImage(named: "Kyle")),
        Friend(name: "Stan Marsh", avatar: UIImage(named: "Stan")),]
    
    let friendsPhotos = [
        FriendsPhoto(name: "Bart Simpson", photos: [UIImage(named: "BartFoto1"),
                                                    UIImage(named: "BartFoto2"),]),
        FriendsPhoto(name: "Butters Stotch", photos: [UIImage(named: "ButtersFoto1")]),
        FriendsPhoto(name: "Eric Cartman", photos: [UIImage(named: "CartmanFoto1"),
                                                    UIImage(named: "CartmanFoto2"),
                                                    UIImage(named: "CartmanFoto3"),
                                                    UIImage(named: "CartmanFoto4")]),
        FriendsPhoto(name: "Homer Simpson", photos: [UIImage(named: "HomerFoto1"),
                                                     UIImage(named: "HomerFoto2"),
                                                     UIImage(named: "HomerFoto3")]),
        FriendsPhoto(name: "Kenny McCormick", photos: [UIImage(named: "KennyFoto1"),
                                                       UIImage(named: "KennyFoto2"),
                                                       UIImage(named: "KennyFoto3"),
                                                       UIImage(named: "KennyFoto4"),]),
        FriendsPhoto(name: "Kyle Broflovski", photos: [UIImage(named: "KyleFoto1"),
                                                       UIImage(named: "KyleFoto2"),
                                                       UIImage(named: "KyleFoto3"),
                                                       UIImage(named: "KyleFoto4")]),
        FriendsPhoto(name: "Stan Marsh", photos: [UIImage(named: "StanFoto1"),
                                                  UIImage(named: "StanFoto2"),
                                                  UIImage(named: "StanFoto3"),
                                                  UIImage(named: "StanFoto4"),
                                                  UIImage(named: "StanFoto5"),
                                                  UIImage(named: "StanFoto6")])
    ]

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsFotoSegue" {
            // Здесь объектом sender является ячейка, на которую нажимает юзер
            // Получаем indexPath выбранной ячейки с помощью метода indexPathForCell:
            let indexPath = self.tableView.indexPath(for: (sender as! UITableViewCell))
            // Получаем объект под нужным индексом
            let image = self.friendsPhotos[indexPath!.row].photos
            // Получаем контроллер, на который юзер попадёт с этим segue
            let photoVC: FriendsFotoController = segue.destination as! FriendsFotoController
            // Задаём атрибут объекту в VC
            photoVC.photo = image as? [UIImage]
        }
    }
}
