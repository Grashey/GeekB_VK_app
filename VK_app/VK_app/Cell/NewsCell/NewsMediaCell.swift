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
        
        let imageUrl = URL(string: data.photo)
        newsImageView.kf.setImage(with: imageUrl)
    }
}
