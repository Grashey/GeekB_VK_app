//
//  NewsfeedViewController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class NewsfeedViewController: UITableViewController {
    
    @IBOutlet var newsTable: UITableView!
    
    var groupAvatars = [UIImage]()
    var groupNames = [String]()
    var groupIndexes = [Int]()
    var indexMax = Int()
    let numberOfRows = 10
    var newGroupAvatars = [UIImage]()
    var newGroupNames = [String]()
    
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getNewsfeed(groupId: "groups", completion: { [weak self] news in
            guard let self = self else { return }
            self.news = news
            self.newsTable.reloadData()
        })
        
//        //симулирую рандомный показ новостей от моих групп (в дальнейшем заменить на timeStamp)
//        let groupVC = storyboard?.instantiateViewController(withIdentifier: "GroupController") as! GroupController
//        indexMax = groupVC.self.groups.count - 1
//        for i in 0...indexMax {
//            groupAvatars.append(groupVC.self.groups[i].avatar!)
//            groupNames.append(groupVC.self.groups[i].name)
//        }
//        for _ in 1...numberOfRows {
//            let randomIndex = Int.random(in: 0...indexMax)
//            groupIndexes.append(randomIndex)
//            newGroupAvatars.append(groupAvatars[randomIndex])
//            newGroupNames.append(groupNames[randomIndex])
//        }
    }
    
    // MARK: - Tableview methods
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        
        let groupId = news[indexPath.row].groupId
        
        let groups = try? RealmService.getData(type: Group.self)
        let group = groups?.filter("id == %@", groupId)
        group?.forEach {
            cell.groupLabel.text = $0.name
            
            let imageUrl = URL(string: $0.avatar)
            cell.groupAvatar.kf.setImage(with: imageUrl)
        }
        
        cell.newsTextView.text = news[indexPath.row].text // TO DO: setup view height
        
        let imageUrl = URL(string: news[indexPath.row].photo)
        cell.newsImageView.kf.setImage(with: imageUrl)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? GroupNewsController
        {
            let index = groupIndexes[indexPath.row]
            photoVC.groupAvatar = groupAvatars[index]
            photoVC.groupName = groupNames[index]
        }
    }
}
