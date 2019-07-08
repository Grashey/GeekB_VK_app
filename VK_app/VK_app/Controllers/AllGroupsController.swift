//
//  AllGroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {
    
    fileprivate let allGroups = [
        Group(name: "Bart", avatar: nil),
        Group(name: "Butters", avatar: nil),
        Group(name: "Cartman", avatar: nil),
        Group(name: "Homer", avatar: nil),
        Group(name: "Kenny", avatar: nil),
        Group(name: "Kyle", avatar: nil),
        Group(name: "Stan", avatar: nil),]
    
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
        
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
        
        groupCell.allGroupNameLabel.text = allGroups[indexPath.row].name
        return groupCell
        
    }
}
