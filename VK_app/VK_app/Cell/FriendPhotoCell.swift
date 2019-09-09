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
    
    public func configure(with photo: Photo) {
        let imageUrl = URL(string: photo.photoUrl)
        photoView.kf.setImage(with: imageUrl)
    }
}

