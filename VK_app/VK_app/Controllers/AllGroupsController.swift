//
//  AllGroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {
    
    var allGroups = [Group]()
    
    @IBOutlet var allGroupsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchActive: Bool = false
    var filteredGroups:[Group] = []
    
    //MARK: - TableViewDataSource methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getPopularGroups() { [weak self] group in
            guard let self = self else { return }
            self.allGroups = group
            self.allGroupsTable.reloadData()
        }
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredGroups.count
        } else {
            return allGroups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        if(searchActive){
            groupCell.groupNameLabel.text = filteredGroups[indexPath.row].name
            
            let imageUrl = URL(string: filteredGroups[indexPath.row].avatar)
            groupCell.groupAvatarView.kf.setImage(with: imageUrl)
            
        } else {
            groupCell.groupNameLabel.text = allGroups[indexPath.row].name
            
            let imageUrl = URL(string: allGroups[indexPath.row].avatar)
            groupCell.groupAvatarView.kf.setImage(with: imageUrl)
        }
        return groupCell
    }
    
    //MARK: - UISearchBar methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredGroups = allGroups.filter ({ (group) -> Bool in
            let tmp: NSString = group.name as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if searchText.isEmpty {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }
}
