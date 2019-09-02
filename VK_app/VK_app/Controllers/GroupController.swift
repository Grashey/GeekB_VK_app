//
//  GroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class GroupController: UITableViewController, UISearchBarDelegate {
    
    var myGroups = [Group]()
    
    @IBOutlet var groupsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func addGroup(segue: UIStoryboardSegue){
        guard let allGroupsVC = segue.source as? AllGroupsController,
            let indexPath = allGroupsVC.tableView.indexPathForSelectedRow
        else { return }

        var newGroup: Group

        if allGroupsVC.searchActive{
            newGroup = allGroupsVC.filteredGroups[indexPath.row]
        } else {
            newGroup = allGroupsVC.allGroups[indexPath.row]
        }

        //guard !myGroups.contains(where: {group -> Bool in
            //group.name == newGroup.name

        //}) else { return }

        //myGroups.append(newGroup)
        tableView.reloadData()
    }
    
    var searchActive : Bool = false
    var filteredGroups:[Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getGroups() { [weak self] group in
            guard let self = self else { return }
            try? RealmService.saveData(objects: group)
            self.myGroups = group
            self.groupsTable.reloadData()
        }
        searchBar.delegate = self
    }
    
    //MARK: - TableViewDataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredGroups.count
        } else {
            return myGroups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        if(searchActive){
            groupCell.groupNameLabel.text = filteredGroups[indexPath.row].name
            
            let imageUrl = URL(string: filteredGroups[indexPath.row].avatar)
            groupCell.groupAvatarView.kf.setImage(with: imageUrl)
        } else {
            groupCell.groupNameLabel.text = myGroups[indexPath.row].name
            
            let imageUrl = URL(string: myGroups[indexPath.row].avatar)
            groupCell.groupAvatarView.kf.setImage(with: imageUrl)
        }
        return groupCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(searchActive){
                myGroups.removeAll { (group) -> Bool in
                    group.name == filteredGroups[indexPath.row].name
                }
                filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                myGroups.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - UISearchBar methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredGroups = myGroups.filter ({ (group) -> Bool in
            let tmp: NSString = group.name as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if searchText.isEmpty {
            searchActive = false
        } else {
            searchActive = true
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupNewsSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? GroupNewsController,
            let groups = try? RealmService.getData(type: Group.self)
        {
            photoVC.groupId = groups[indexPath.row].id
            }
        }
}

extension GroupController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushAnimator()
    }
}
