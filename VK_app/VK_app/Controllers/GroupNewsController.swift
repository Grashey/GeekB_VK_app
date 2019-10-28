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
    var groups = [NewsGroup]()
    var profiles = [NewsProfile]()
    let newsPostDateFormatter = NewsfeedDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getNewsfeed(groupId: -groupId, completion: { [weak self] news, groups, profiles  in
            guard let self = self else { return }
            self.news = news
            self.groups = groups
            self.profiles = profiles
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
        return news[section].data.count + 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = news[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderCell", for: indexPath) as! NewsHeaderCell
            for element in groups {
                if -data.groupId == element.groupId {
                    cell.configure(with: element, date: data.date, postDateFormatter: newsPostDateFormatter)
                    return cell
                }
            }
            
        } else if indexPath.row == news[indexPath.section].data.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFooterCell", for: indexPath) as! NewsFooterCell
            cell.configure(with: data)
            return cell
            
        } else if !news[indexPath.section].data.isEmpty {
            for (index, element) in news[indexPath.section].data.enumerated() {
                if indexPath.row == index + 1 {
                    if element == "NewsTextCell" {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
                        cell.configure(with: data)
                        return cell
                    } else if element == "NewsMediaCell" {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsMediaCell", for: indexPath) as! NewsMediaCell
                        cell.configure(with: data)
                        return cell
                    }  else if element == "NewsProfileCell" {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsProfileCell", for: indexPath) as! NewsProfileCell
                        for element in profiles {
                            if data.userId == element.userId {
                                cell.configure(with: element)
                                return cell
                           }
                       }
                    }
                }
            }
        }
        return UITableViewCell()
    }
}
