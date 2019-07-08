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
        Group(name: "123", avatar: nil),
        Group(name: "234", avatar: nil),
        Group(name: "345", avatar: nil),
        Group(name: "456", avatar: nil),
        Group(name: "567", avatar: nil),
        Group(name: "678", avatar: nil),
        Group(name: "789", avatar: nil),]
    
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
        return groupCell
        
    }
}
