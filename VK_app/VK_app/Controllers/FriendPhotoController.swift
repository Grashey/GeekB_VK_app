//
//  FriendsFotoController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendPhotoController: UICollectionViewController {
    
    
    @IBOutlet var photoView: UICollectionView!
    
    var photos = [UIImage]()
    

    //MARK: - CollectionViewDataSource methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendFotoCell", for: indexPath) as! FriendPhotoCell
        
           cell.photoView.image = photos[indexPath.item]
        
        return cell
    }
    
    override func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
   //TODO добавить передачу выбранного фото в PhotoViewController
    }
    
}


