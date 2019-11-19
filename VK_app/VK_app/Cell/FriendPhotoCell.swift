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
    
    public func configure(with photo: Photo, by photoService: PhotoService) {
        let urlString = photo.photoUrl
        photoService.photo(urlString: urlString) { [weak self] image in
            guard let self = self else { return }
            self.photoView.image = image
        }
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
         
         setNeedsLayout()
     }
}
