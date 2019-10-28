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
    @IBOutlet weak var timeLabel: UILabel!
    
    public func configure(with group: NewsGroup, date: Int, postDateFormatter: NewsfeedDateFormatter) {
        groupLabel.text = group.groupName
        
        let imageUrl = URL(string: group.groupAvatar)
        groupAvatar.kf.setImage(with: imageUrl)
        
        timeLabel.text = postDateFormatter.getcurrentDate(date: date)
    }
}
