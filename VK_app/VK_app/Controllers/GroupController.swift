//
//  GroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class GroupController: UITableViewController {
    
    fileprivate var groups = [
        Group(name: "MIB", avatar: UIImage(named: "GroupMIB")),
        Group(name: "Be Happy", avatar: UIImage(named: "GroupSmile")),
        Group(name: "Cinema", avatar: UIImage(named: "Group3D")),
        Group(name: "Will Smith Fan Zone", avatar: UIImage(named: "GroupWillSmith")),
        Group(name: "Shit Happens", avatar: UIImage(named: "GroupMonster")),
        Group(name: "Angry Birds Community", avatar: UIImage(named: "GroupAngryBirds")),
        Group(name: "Engineering", avatar: UIImage(named: "GroupLabirint")),]
    
    @IBOutlet var groupsTable: UITableView!
    @IBAction func addGroup(segue: UIStoryboardSegue){
        guard let allGroupsVC = segue.source as? AllGroupsController,
            let indexPath = allGroupsVC.tableView.indexPathForSelectedRow
        else { return }
        
        let newGroup = allGroupsVC.allGroups[indexPath.row]
        
        guard !groups.contains(where: {group -> Bool in
            group.name == newGroup.name
            
        }) else { return }
        groups.append(newGroup)
        tableView.reloadData()
        
    }
    
    //MARK: - TableViewDataSource methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        
        groupCell.groupNameLabel.text = groups[indexPath.row].name
        groupCell.groupAvatarView.image = groups[indexPath.row].avatar
        
        return groupCell
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
