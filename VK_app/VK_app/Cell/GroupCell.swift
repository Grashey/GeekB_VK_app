//
//  GroupCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupAvatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let springGR = UITapGestureRecognizer(target: self, action: #selector(compression))
        groupAvatarView.addGestureRecognizer(springGR)
    }

    @objc func compression() {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.groupAvatarView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 100, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.groupAvatarView.transform = CGAffineTransform.identity
            }, completion: nil)
        })
    }
}
