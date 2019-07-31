//
//  FriendsFotoController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendPhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var photoView: UICollectionView!
    
    var photos = [UIImage]()

    //MARK: - CollectionViewDataSource methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (view.frame.width-20)/3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendFotoCell", for: indexPath) as! FriendPhotoCell
        
           cell.photoView.image = photos[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
        cell.layer.opacity = 0
        
        UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, animations: {
            cell.layer.opacity = 1
        }, completion: nil)
        
    }
    
    override func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoVC = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        let photo = collectionView.cellForItem(at: indexPath) as! FriendPhotoCell
        photoVC.photoFullScreen = photo.photoView.image!
        photoVC.index = indexPath.item
        photoVC.photos = photos
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
    
}


