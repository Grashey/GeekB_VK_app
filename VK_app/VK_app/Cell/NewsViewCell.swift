//
//  NewsViewCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 25/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var newsText: UITextView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var repostImage: UIImageView!
    @IBOutlet weak var repostCount: UILabel!
    @IBOutlet weak var viewCountImage: UIImageView!
    @IBOutlet weak var viewCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
