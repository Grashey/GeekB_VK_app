//
//  NewsPhotoCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 01.11.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsPhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoCollection: NewsPhotoCollection!

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        
        let layout = NewsCollectionViewLayout()
        
        photoCollection.collectionViewLayout = layout
        photoCollection.delegate = dataSourceDelegate
        photoCollection.dataSource = dataSourceDelegate
        photoCollection.tag = row
        photoCollection.reloadData()
    }

}
