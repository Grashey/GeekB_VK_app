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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getPhotos(userId: "\(friendId)") { photos in
            try? RealmService.saveData(objects: photos)
            self.collectionView.reloadData()
        }
    }

    //MARK: - CollectionViewDataSource methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let allPhotos = try? RealmService.getData(type: Photo.self)
        let photos = allPhotos?.filter("ownerId == [cd] %@", String(friendId))
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (view.frame.width-20)/3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let allPhotos = try? RealmService.getData(type: Photo.self)
        let photos = allPhotos?.filter("ownerId == [cd] %@", String(friendId))
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCell
        let imageUrl = URL(string: photos?[indexPath.item].photoUrl ?? "") // TO DO: ""
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
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}


