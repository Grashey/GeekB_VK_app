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
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    @IBOutlet weak var likeImageView: LikeImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var repostImageView: UIImageView!
    @IBOutlet weak var repostCountLabel: UILabel!
    
    @IBOutlet weak var viewCountImageView: UIImageView!
    @IBOutlet weak var viewCountLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
