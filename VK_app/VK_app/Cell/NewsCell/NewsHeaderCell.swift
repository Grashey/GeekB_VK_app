//
//  NewsHeaderCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsHeaderCell: UITableViewCell {

    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    
    public func configure(with group: Group) {
        groupLabel.text = group.name
        
        let imageUrl = URL(string: group.avatar)
        groupAvatar.kf.setImage(with: imageUrl)
    }
}
