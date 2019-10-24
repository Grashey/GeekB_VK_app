//
//  FriendsFotoController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendPhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var photoView: UICollectionView!
    
    var friendId = Int()
    var photos: Results<Photo>?
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        networkService.getPhotos(userId: "\(friendId)") { photos in
            try? RealmService.saveData(objects: photos)
            self.linkPhotosToFriend(userId: self.friendId, photos: photos)
        }
        
        photos = try? RealmService.getData(type: Photo.self).filter("ownerId == [cd] %@", String(self.friendId))
        notificationToken = photos?.observe { change in
            switch change {
            case .initial:
                self.collectionView.reloadData()
            case .update:
                self.collectionView.reloadData()
            case .error(let error):
                self.show(error)
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }

    //MARK: - CollectionViewDataSource methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (view.frame.width-20)/3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCell
        if let photo = photos?[indexPath.row] {
            cell.configure(with: photo)
        }
        
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
        photoVC.ownerId = friendId
        photoVC.index = indexPath.item
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
    
    func linkPhotosToFriend(userId: Int, photos: [Photo]) {
        var currentFriend = Friend()
        do {
            let realm = try Realm()
            let friend = realm.objects(Friend.self).filter("id == [cd] %@", userId)
            for object in friend {
                currentFriend = object
            }
            realm.beginWrite()
            currentFriend.photos.append(objectsIn: photos)
            try realm.commitWrite()
        } catch {
            self.show(error)
        }
    }
}


