//
//  NewsProfileCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/10/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsProfileCell: UITableViewCell {

    @IBOutlet weak var profileAvatar: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    static let reuseID = String(describing: NewsProfileCell.self)
    
    public func configure(with data: NewsProfile) {
        
        profileNameLabel.text = data.userName + " " + data.userSurname
        
        let imageUrl = URL(string: data.userAvatar)
        profileAvatar.kf.setImage(with: imageUrl)
    }
    
}
