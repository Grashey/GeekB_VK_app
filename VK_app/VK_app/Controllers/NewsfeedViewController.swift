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
    var groups = [NewsGroup]()
    var profiles = [NewsProfile]()
    let newsPostDateFormatter = NewsfeedDateFormatter()
    let networkService = NetworkService()
    var isLoading = false
    var nextFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewsHeaderCell.self, forCellReuseIdentifier: NewsHeaderCell.reuseID)
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.reuseID)
        
        networkService.getNewsfeed(groupId: "groups", completion: { [weak self] news, groups, profiles, nextFrom  in
            guard let self = self else { return }
            self.news = news
            self.groups = groups
            self.profiles = profiles
            self.nextFrom = nextFrom
            self.newsfeedTable.reloadData()
        })
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl!.tintColor = .red
        refreshControl!.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        
        tableView.prefetchDataSource = self
    }
    
    // MARK: -  Private helper methods
    @objc func refreshNews(_ sender: Any) {
        let firstNewsDate = news.first!.date + 1
        networkService.getNewsfeed(groupId: "groups", startTime: firstNewsDate) { news, groups, profiles, _  in
            guard news.count > 0 else { self.refreshControl?.endRefreshing(); return }
            self.news = news + self.news
            self.groups = groups + self.groups
            self.profiles = profiles + self.profiles
            let indexSet = IndexSet(integersIn: 0..<news.count)
            self.tableView.insertSections(indexSet, with: .automatic)
            self.refreshControl?.endRefreshing()
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderCell.reuseID, for: indexPath) as! NewsHeaderCell
            for element in groups {
                if -data.groupId == element.groupId {
                    cell.configure(with: element, date: data.date, postDateFormatter: newsPostDateFormatter)
                    return cell
                }
            }
            
        } else if indexPath.row == news[indexPath.section].data.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseID, for: indexPath) as! NewsFooterCell
            cell.configure(with: data)
            return cell
            
        } else if !news[indexPath.section].data.isEmpty {
            for (index, element) in news[indexPath.section].data.enumerated() {
                if indexPath.row == index + 1 {
                    
                    switch element {
                    case NewsTextCell.reuseID:
                        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseID, for: indexPath) as! NewsTextCell
                        cell.configure(with: data)
                        cell.newsTextView.isScrollEnabled = cell.heightForScroll(with: data)
                        return cell
                        
                    case NewsPhotoCell.reuseID:
                        let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseID, for: indexPath) as! NewsPhotoCell
                        //cell.configure(with: data)
                        return cell
                        
                    case NewsProfileCell.reuseID:
                        let cell = tableView.dequeueReusableCell(withIdentifier: NewsProfileCell.reuseID, for: indexPath) as! NewsProfileCell
                        for element in profiles {
                            if data.userId == element.userId {
                                cell.configure(with: element)
                                return cell
                            }
                        }
                        
                    default:
                        return UITableViewCell()
                    }
                }
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? NewsPhotoCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = UITableView.automaticDimension
        
        if indexPath.row == 0 {
            let cell = NewsHeaderCell()
            height = cell.heightForCell()
            
        } else if indexPath.row == news[indexPath.section].data.count + 1 {
            let cell = NewsFooterCell()
            height = cell.heightForCell()
            
        } else if !news[indexPath.section].data.isEmpty {
            for (index, element) in news[indexPath.section].data.enumerated() {
                if indexPath.row == index + 1 {
                    if element == NewsTextCell.reuseID {
                        let cell = NewsTextCell()
                        let data = news[indexPath.section]
                        height = cell.heightForCell(with: data)
                        
                    } else if element == NewsPhotoCell.reuseID {
                        if news[indexPath.section].photos.count == 1 {
                            let tableWidth = tableView.bounds.width
                            let news = self.news[indexPath.section]
                            height = tableWidth * news.aspectRatio
                        } else if news[indexPath.section].photos.count == 2 {
                            let tableWidth = tableView.bounds.width
                            let news = self.news[indexPath.section]
                            height = tableWidth / 2 * news.aspectRatio
                        } else {
                            height = 450
                        }
                    }
                }
            }
        }
        return height
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "NewsSegue",
//            let indexPath = tableView.indexPathForSelectedRow,
//            let newsVC = segue.destination as? GroupNewsController
//        {
//            newsVC.groupId = -news[indexPath.section].groupId
//        }
//    }
}

extension NewsfeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return news[collectionView.tag].photos.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsPhotoCollectionCell.reuseID, for: indexPath) as! NewsPhotoCollectionCell
        
        let photosString = news[collectionView.tag].photos
        let urlString = photosString[indexPath.item]
        let imageUrl = URL(string: urlString)
        cell.photoView.kf.setImage(with: imageUrl)
        for (index,_) in photosString.enumerated() {
            switch index {
            case 0:
                cell.photoView.contentMode = .scaleAspectFit
            default:
                cell.photoView.contentMode = .scaleAspectFill
            }
        }
        return cell
    }
}

extension NewsfeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > news.count - 3,
            !isLoading {
            isLoading = true
            networkService.getNewsfeed(groupId: "groups", startFrom: nextFrom) { [weak self] (news,groups,profiles, nextFrom) in
                self?.news.append(contentsOf: news)
                self?.groups.append(contentsOf: groups)
                self?.profiles.append(contentsOf: profiles)
                self?.nextFrom = nextFrom
                self?.tableView.reloadData()
                self?.isLoading = false
            }
        }
    }
}
