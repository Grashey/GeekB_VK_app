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
    
    @IBOutlet var newsfeedTable: UITableView!
    
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getNewsfeed(groupId: "groups", completion: { [weak self] news in
            guard let self = self else { return }
            self.news = news
            self.newsfeedTable.reloadData()
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
            let groupId = news[indexPath.section].groupId
            let group = groups?.filter("id == %@", groupId)
            group?.forEach {
                cell.groupLabel.text = $0.name
                let imageUrl = URL(string: $0.avatar)
                cell.groupAvatar.kf.setImage(with: imageUrl)
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
        self.newsfeedTable.reloadData()
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let newsVC = segue.destination as? GroupNewsController
        {
            newsVC.groupId = news[indexPath.section].groupId
        }
    }
}
