//
//  FriendsFotoController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Kingfisher

class FriendPhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var photoView: UICollectionView!
    
    var friendId = Int()
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getFriendsPhotos(userId: "\(friendId)") { [weak self] photos in
            guard let self = self else { return }
            try? RealmService.saveData(objects: photos)
            self.photos = photos
            self.photoView.reloadData()
        }
    }

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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCell
        let imageUrl = URL(string: photos[indexPath.item].photoUrl)
        cell.photoView.kf.setImage(with: imageUrl)
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
        cell.layer.opacity = 0
        
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
            cell.layer.opacity = 1
        }, completion: nil)
    }
    
    override func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoVC = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        photoVC.index = indexPath.item
        photoVC.photos = photos
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}


