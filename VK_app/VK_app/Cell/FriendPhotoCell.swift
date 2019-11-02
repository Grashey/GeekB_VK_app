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
    
    static let reuseID = String(describing: FriendPhotoCell.self)
    
    public func configure(with photo: Photo, by photoService: PhotoService) {
        let urlString = photo.photoUrl
        photoService.photo(urlString: urlString) { [weak self] image in
            self?.photoView.image = image
        }
    }
}
