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
    
    var groupAvatar = UIImage()
    var groupName = String()
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
        
        //cell.groupAvatar.image = newGroupAvatars[indexPath.row]
        //cell.groupLabel.text = newGroupNames[indexPath.row]
        print(indexPath.row)
        cell.newsTextView.text = news[indexPath.row].text // TO DO: setup view height
        
        let imageUrl = URL(string: news[indexPath.row].photo)
        cell.newsImageView.kf.setImage(with: imageUrl)
        
        return cell
    }
}
