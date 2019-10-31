//
//  NewsMediaCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsMediaCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!

    public func configure(with data: News) {
        let photos = data.photos
        for i in 0...photos.count - 1 {
            let imageUrl = URL(string: photos[i])
            newsImageView.kf.setImage(with: imageUrl)
        }
    }
}
