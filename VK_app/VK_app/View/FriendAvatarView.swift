//
//  FriendAvatarView.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 13/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendAvatarView: UIView {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var shadowView: UIView!
    
    var shadowColor: UIColor = UIColor.black
    var shadowOffset: CGSize = .zero
    var shadowRadius: CGFloat = 6
    var shadowOpacity: Float = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOpacity = shadowOpacity
        
        shadowView.backgroundColor = UIColor.white
        avatarImageView.backgroundColor = .clear
        
        //shadowView.layer.masksToBounds = true
        avatarImageView.layer.masksToBounds = true
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.layer.cornerRadius = shadowView.frame.height/2
        avatarImageView.layer.cornerRadius = shadowView.layer.cornerRadius
    }
}
