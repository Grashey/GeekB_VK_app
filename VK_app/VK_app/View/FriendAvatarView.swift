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
        avatarImageView.backgroundColor = UIColor.white
        
        avatarImageView.layer.masksToBounds = true
        
        let springGR = UITapGestureRecognizer(target: self, action: #selector(compression))
        avatarImageView.addGestureRecognizer(springGR)
   
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.layer.cornerRadius = shadowView.frame.height/2
        avatarImageView.layer.cornerRadius = shadowView.layer.cornerRadius
        
    }
    
    @objc func compression() {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.avatarImageView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
            self.shadowView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.avatarImageView.transform = CGAffineTransform.identity
                self.shadowView.transform = CGAffineTransform.identity
            }, completion: nil)
        }) }
    

}
