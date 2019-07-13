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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
            
    }

    @IBInspectable var borderColor: UIColor = UIColor.black;
    @IBInspectable var borderSize: CGFloat = 1
    
    override func draw(_ rect: CGRect){
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderSize
        layer.cornerRadius = self.frame.height/2
    }
    

    
}
