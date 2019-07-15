//
//  FriendAvatarView.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 13/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

@IBDesignable

class FriendAvatarView: UIView {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var shadowView: UIView!
    
    @IBInspectable var shadowColor: UIColor = UIColor.black;
    @IBInspectable var shadowOffset: CGSize = .zero
    @IBInspectable var shadowRadius: CGFloat = 6
    @IBInspectable var shadowOpacity: Float = 1
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOpacity = shadowOpacity
        
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.cornerRadius = shadowView.frame.height/2
        
        avatarImageView.layer.cornerRadius = shadowView.layer.cornerRadius
            
    }

    
    
}
