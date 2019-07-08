//
//  GroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class GroupsController: UITableViewController {
    
    fileprivate var groups = [
        Group(name: "111", avatar: nil),
        Group(name: "222", avatar: nil),
        Group(name: "333", avatar: nil),
        Group(name: "444", avatar: nil),
        Group(name: "555", avatar: nil),
        Group(name: "666", avatar: nil),
        Group(name: "777", avatar: nil),]
    
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
        return groupCell
        
    }
}
