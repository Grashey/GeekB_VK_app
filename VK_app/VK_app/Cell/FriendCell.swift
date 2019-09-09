//
//  FriendCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

protocol FriendCellDelegate {
    func performSegueFromView(sender: IndexPath)
}

class FriendCell: UITableViewCell {

    @IBOutlet weak var friendAvatarView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet var shadowView: UIView!
    
    var delegate: FriendCellDelegate?
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let springGR = UITapGestureRecognizer(target: self, action: #selector(compression))
        friendAvatarView.addGestureRecognizer(springGR)
    }
    
    @objc func compression() {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.friendAvatarView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
            self.shadowView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.friendAvatarView.transform = CGAffineTransform.identity
                self.shadowView.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.delegate?.performSegueFromView(sender: self.indexPath)
            })
        })
    }
}
