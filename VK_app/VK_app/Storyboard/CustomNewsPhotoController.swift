//
//  CustomNewsPhotoController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 31.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class CustomNewsPhotoController: UITableViewController {
    
    @IBOutlet var customNewsfeedTable: UITableView!
    
    var groupId = Int()
    var news = [News]()
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getNewsfeed(groupId: -groupId, completion: { [weak self] news, groups, profiles  in
            guard let self = self else { return }
            self.news = news
            self.customNewsfeedTable.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNewsPhotoCell", for: indexPath) as! CustomNewsPhotoCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CustomNewsPhotoCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        //return UITableView.automaticDimension
    }
}

extension CustomNewsPhotoController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return news[collectionView.tag].photos.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as! CustomCollectionCell
        
        let photosString = news[collectionView.tag].photos
        let urlString = photosString[indexPath.item]
        let imageUrl = URL(string: urlString)
        cell.photoView.kf.setImage(with: imageUrl)
        return cell
    } 
}
