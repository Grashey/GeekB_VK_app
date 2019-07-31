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
    @IBOutlet weak var photoCountView: UILabel!
    
    var photoFullScreen = UIImage()
    var likeCount = 0
    var index = Int()
    var photos = [UIImage]()
    
    override func viewDidLoad() {
        
        photoFullScreenView.image = photoFullScreen
        likeCountView.text = String(likeCount)
        photoCountView.text = String("\(index + 1) / \(photos.count)")
        
        let likeGR = UITapGestureRecognizer(target: self, action: #selector(heartStateChanged))
        likeGR.numberOfTapsRequired = 2
        photoFullScreenView.addGestureRecognizer(likeGR)
        
        let flipLeftGR = UISwipeGestureRecognizer(target: self, action: #selector(flipLeftPhotos))
        flipLeftGR.direction = .left
        photoFullScreenView.addGestureRecognizer(flipLeftGR)
        
        let flipRightGR = UISwipeGestureRecognizer(target: self, action: #selector(flipRightPhotos))
        flipRightGR.direction = .right
        photoFullScreenView.addGestureRecognizer(flipRightGR)
        
    }
    
    @objc func flipRightPhotos(){
        guard index != 0
            else { return }
        index -= 1
        photoFullScreenView.image = photos[index]
        photoCountView.text = String("\(index + 1) / \(photos.count)")
        reloadInputViews()
        
    }
    
    @objc func flipLeftPhotos(){
        guard index != (photos.count - 1)
            else { return }
        index += 1
        photoFullScreenView.image = photos[index]
        photoCountView.text = String("\(index + 1) / \(photos.count)")
        reloadInputViews()
    }
    
    
    
    @objc private func heartStateChanged(){
        likeImageView.isHeartFilled.toggle()
        if likeCountView.text == String(likeCount){
            flipCountUp(String(likeCount + 1))
        } else {
            flipCountDown(String(likeCount))
        }
    }
    
    //MARK: - Animation
    private func flipCountUp(_ text: String) {
        UIView.transition(with: likeCountView, duration: 0.4, options: .transitionFlipFromRight, animations: {
        self.likeCountView.text = text
        })
    }
    
    private func flipCountDown(_ text: String) {
        UIView.transition(with: likeCountView, duration: 0.4, options: .transitionFlipFromLeft, animations: {
            self.likeCountView.text = text
        })
    }
    
    
}
