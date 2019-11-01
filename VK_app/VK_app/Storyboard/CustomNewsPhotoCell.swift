//
//  CustomNewsPhotoCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 31.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class CustomNewsPhotoCell: UITableViewCell {

    @IBOutlet fileprivate weak var customNewsfeedCollection: CustomNewsfeedCollection!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        
        let layout = UICollectionViewFlowLayout()
        let wight = self.bounds.width
        let height = self.bounds.height - 10
        layout.itemSize = CGSize(width: wight, height: height)
        customNewsfeedCollection.collectionViewLayout = layout
        
        customNewsfeedCollection.delegate = dataSourceDelegate
        customNewsfeedCollection.dataSource = dataSourceDelegate
        customNewsfeedCollection.tag = row
        customNewsfeedCollection.reloadData()
    }
}
