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
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderCell", for: indexPath) as! NewsHeaderCell
            let groups = try? RealmService.getData(type: Group.self)
            let filteredGroup = groups?.filter("id == %@", groupId)
            if let group = filteredGroup?[indexPath.row] {
                let date = news[indexPath.section].date
                cell.configure(with: group, date: date)
            }
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
            cell.newsTextView.text = news[indexPath.section].text //TO DO: setup view height
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsMediaCell", for: indexPath) as! NewsMediaCell
            let imageUrl = URL(string: news[indexPath.section].photo) // TO DO: collectionview for images
            cell.newsImageView.kf.setImage(with: imageUrl) //TO DO: setup view height
            return cell
            
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFooterCell", for: indexPath) as! NewsFooterCell
            return cell
        }
        return UITableViewCell()
    }
}
