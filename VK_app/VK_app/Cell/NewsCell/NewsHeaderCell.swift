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
    
    public func configure(with group: Group, date: Int) {
        groupLabel.text = group.name
        
        let imageUrl = URL(string: group.avatar)
        groupAvatar.kf.setImage(with: imageUrl)
        
        let currentDateTime = Date().timeIntervalSince1970
        let interval = Int(currentDateTime) - date
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        let formattedString = formatter.string(from: TimeInterval(interval))!
        timeLabel.text = ("\(formattedString) назад")
    }
}
