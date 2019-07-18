//
//  PhotoViewController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 16/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
@IBDesignable

class PhotoViewController: UIViewController {

   
    @IBOutlet weak var photoFullScreenView: UIImageView!
    @IBOutlet weak var likeCountView: UILabel!
    @IBOutlet var likeImageView: LikeImageView!
    
    var photoFullScreen = UIImage()
    var likeCount = 0
    
    override func viewDidLoad() {
        photoFullScreenView.image = photoFullScreen
        likeCountView.text = String(likeCount)
        
        let likeGR = UITapGestureRecognizer(target: self, action: #selector(heartStateChanged))
        likeGR.numberOfTapsRequired = 1
        photoFullScreenView.addGestureRecognizer(likeGR)
        
    }
    
    @objc private func heartStateChanged(){
        likeImageView.isHeartFilled.toggle()
        if likeCountView.text == String(likeCount){
            likeCountView.text = String(likeCount + 1)
        } else {
            likeCountView.text = String(likeCount)
        }
    }

    
}
