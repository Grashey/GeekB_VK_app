//
//  FriendsFotoController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class FriendPhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var photoView: UICollectionView!
    
    var friend = Int()
    var photos = [FriendsPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
//        networkService.getFriendsPhotos(userId: "\(friend)") { [weak self] photos in
//            guard let self = self else { return }
//            self.photos = photos
//            self.photoView.reloadData()
//        }
        let special = ["wall", "profile", "saved"]
        special.forEach {
            let id = String($0.self)
            print(id)
        networkService.getPhotos(userId: "\(self.friend)", albumId: id) { [weak self] photos in
            guard let self = self else { return }
            self.photos += photos
            self.photoView.reloadData()
            print(self.photos.count)
            }}
        
        networkService.getPhotoAlbums(userId: "\(friend)") { [weak self] albums in
            guard let self = self else { return }

            albums.forEach {
                print($0.id, $0.albumTitle)
            let albumId = $0.id
            //let albumTitle = $0.albumTitle
                sleep(1) // средство против ограничения кол-ва запросов в секунду - пока не найду решение
                networkService.getPhotos(userId: "\(self.friend)", albumId: albumId) { [weak self] photos in
                    guard let self = self else { return }
                    self.photos += photos
                    self.photoView.reloadData()
                    print(self.photos.count)
                }
            }
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


