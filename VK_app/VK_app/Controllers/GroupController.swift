//
//  GroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class GroupController: UITableViewController, UISearchBarDelegate {
    
    var groups = [
        Group(name: "MIB", avatar: UIImage(named: "GroupMIB")),
        Group(name: "Be Happy", avatar: UIImage(named: "GroupSmile")),
        Group(name: "Cinema", avatar: UIImage(named: "Group3D")),
        Group(name: "Will Smith Fan Zone", avatar: UIImage(named: "GroupWillSmith")),
        Group(name: "Shit Happens", avatar: UIImage(named: "GroupMonster")),
        Group(name: "Angry Birds Community", avatar: UIImage(named: "GroupAngryBirds")),
        Group(name: "Engineering", avatar: UIImage(named: "GroupLabirint")),]
    
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

        guard !groups.contains(where: {group -> Bool in
            group.name == newGroup.name
            
        }) else { return }
        
        groups.append(newGroup)
        tableView.reloadData()
    }
    
    var searchActive : Bool = false
    var filteredGroups:[Group] = []
    
    //MARK: - TableViewDataSource methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.sendRequest(object: "groups")
        networkService.sendRequestGroupProfile(groupId: "35850939")
        networkService.groupSearch(searchtext: "geekbrains")
        
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredGroups.count
        } else {
            return groups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        if(searchActive){
            groupCell.groupNameLabel.text = filteredGroups[indexPath.row].name
            groupCell.groupAvatarView.image = filteredGroups[indexPath.row].avatar
        } else {
            groupCell.groupNameLabel.text = groups[indexPath.row].name
            groupCell.groupAvatarView.image = groups[indexPath.row].avatar
        }
        return groupCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(searchActive){
                groups.removeAll { (group) -> Bool in
                    group.name == filteredGroups[indexPath.row].name
                }
                filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                groups.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - UISearchBar methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredGroups = groups.filter ({ (group) -> Bool in
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
            let photoVC = segue.destination as? GroupNewsController
        {
            photoVC.groupAvatar = groups[indexPath.row].avatar! as UIImage
            photoVC.groupName = groups[indexPath.row].name
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
