//
//  FriendsFotoCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {
  
    
    @IBOutlet weak var photoView: UIImageView!
    
    
    override func awakeFromNib() {
        emersion()
    }
    
    @objc func emersion() {
        self.photoView.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
        self.photoView.layer.opacity = 0
        
        UIView.animate(withDuration: 3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.photoView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animateKeyframes(withDuration: 3, delay: 0, animations: {
            self.photoView.layer.opacity = 1
            }, completion: nil)
        }
}

