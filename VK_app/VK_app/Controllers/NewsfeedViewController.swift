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
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "logOutSegue", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    var news = [News]()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getNewsfeed(groupId: "groups", completion: { [weak self] news in
            guard let self = self else { return }
            self.news = news
            DispatchQueue.main.async { self.newsfeedTable.reloadData() }
        })
        formatter.timeStyle = .short
        formatter.dateStyle = .none
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
            let groupId = news[indexPath.section].groupId
            NetworkService.getGroupById(id: groupId, completion: { group in
                guard let group = group.first else { return }
                cell.configure(with: group, date: data.date)
            })
            return cell
            
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
                    }
                }
            }
        }
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


