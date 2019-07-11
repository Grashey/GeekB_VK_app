//
//  FriendsFotoController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class FriendsFotoController: UICollectionViewController {
    
    
    @IBOutlet var fotosView: UICollectionView!
    
    var photo: [UIImage]?

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if photo != nil {
            return photo!.count
        } else {return 1}
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsFotoCell", for: indexPath) as! FriendsFotoCell
        
        if photo != nil {
            for i in 0..<photo!.count {
                cell.fotoView.image = photo![i]
            }} else {
                cell.fotoView.image = UIImage(named: "defaultAva")
            }
        
        return cell
    }
}
