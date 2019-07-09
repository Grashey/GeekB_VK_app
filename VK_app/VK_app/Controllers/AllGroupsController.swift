//
//  AllGroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {
    
    var allGroups = [
        Group(name: "Mortal Combat", avatar: UIImage(named: "GroupMortalCombat")),
        Group(name: "Funny Bunnies", avatar: UIImage(named: "GroupBunny")),
        Group(name: "Euphoria", avatar: UIImage(named: "GroupDrugs")),
        Group(name: "Hulk Fan Club", avatar: UIImage(named: "GroupHulk")),
        Group(name: "Video Games", avatar: UIImage(named: "GroupMinion")),
        Group(name: "Hackers", avatar: UIImage(named: "GroupRadiation")),
        Group(name: "Passion", avatar: UIImage(named: "GroupLips")),
        Group(name: "MIB", avatar: UIImage(named: "GroupMIB")),
        Group(name: "Be Happy", avatar: UIImage(named: "GroupSmile")),
        Group(name: "Cinema", avatar: UIImage(named: "Group3D")),
        Group(name: "Will Smith Fan Zone", avatar: UIImage(named: "GroupWillSmith")),
        Group(name: "Shit Happens", avatar: UIImage(named: "GroupMonster")),
        Group(name: "Angry Birds Community", avatar: UIImage(named: "GroupAngryBirds")),
        Group(name: "Engineering", avatar: UIImage(named: "GroupLabirint")),]
    
    @IBOutlet var allGroupsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        
        groupCell.groupNameLabel.text = allGroups[indexPath.row].name
        if allGroups[indexPath.row].avatar == nil {
            groupCell.groupAvatarView.image = UIImage(named: "defaultGroup")
        } else {
            groupCell.groupAvatarView.image = allGroups[indexPath.row].avatar
        }
        return groupCell
        
    }
}
