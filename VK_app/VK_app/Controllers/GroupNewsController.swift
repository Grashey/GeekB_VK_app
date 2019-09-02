//
//  NewsfeedViewController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 25/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class GroupNewsController: UITableViewController {
    
    @IBOutlet var newsTable: UITableView!
    
    var groupId = Int()
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getNewsfeed(groupId: -groupId, completion: { [weak self] news in
            guard let self = self else { return }
            self.news = news
            self.newsTable.reloadData()
        })
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
}
