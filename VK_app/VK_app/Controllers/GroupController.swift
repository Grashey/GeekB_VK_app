//
//  GroupsController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class GroupController: UITableViewController, UISearchBarDelegate {

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
        //tableView.reloadData()
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "logOutSegue", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    var myGroups: Results<Group>?
    var searchActive : Bool = false
    var filteredGroups: Results<Group>?
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let q = OperationQueue()
        let parameters: Parameters = [
                   "v" : "5.96",
                   "access_token" : Session.instance.token,
                   "extended" : 1
               ]
        
        let url = "https://api.vk.com/method/groups.get"
        let request = Alamofire.request(url, method: .get, parameters: parameters)
        let getDataOperation = GetGroupData(request: request)
        q.addOperation(getDataOperation)
        
        let parseData = ParseGroupData()
        parseData.addDependency(getDataOperation)
        q.addOperation(parseData)
        
        let saveData = SaveGroupData()
        saveData.addDependency(parseData)
        q.addOperation(saveData)
             
        self.myGroups = try? RealmService.getData(type: Group.self)
        
        notificationToken = myGroups?.observe { change in
            switch change {
            case .initial:
                self.tableView.reloadData()
            case .update(_ , let deletions, let insertions, let modifications):
                self.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
                print(deletions)
                print(insertions)
                print(modifications)
            case .error(let error):
                self.show(error)
            }
        }
        searchBar.delegate = self
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    //MARK: - TableViewDataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredGroups?.count ?? 0
        } else {
            return myGroups?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        if searchActive {
            if let group = filteredGroups?[indexPath.row] {
                cell.configure(with: group)
            }
        } else {
            if let group = myGroups?[indexPath.row] {
                cell.configure(with: group)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if searchActive {
                let groupId = filteredGroups?[indexPath.row].id
                guard let object = myGroups?.filter("id = %@", groupId ?? 0) else { return }
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    realm.delete(object)
                    try realm.commitWrite()
                } catch {
                    show(error)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                let groupId = myGroups?[indexPath.row].id
                guard let object = myGroups?.filter("id = %@", groupId ?? 0) else { return }
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    realm.delete(object)
                    try realm.commitWrite()
                } catch {
                    show(error)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - UISearchBar methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchActive = false
        } else {
            searchActive = true
        }
        
        filteredGroups = myGroups?.filter("name CONTAINS[cd] %@", searchText)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupNewsSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? CustomNewsPhotoController
        {
            if searchActive {
                photoVC.groupId = filteredGroups?[indexPath.row].id ?? 0
            } else {
                photoVC.groupId = myGroups?[indexPath.row].id ?? 0
            }
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
