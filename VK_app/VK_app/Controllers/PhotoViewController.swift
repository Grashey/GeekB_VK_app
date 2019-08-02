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
    @IBOutlet weak var nextPhotoView: UIImageView!
    
    var likeCount = 0
    var index = Int()
    var photos = [UIImage]()
    
    override func viewDidLoad() {
        
        photoFullScreenView.image = photos[index]
        likeCountView.text = String(likeCount)
        nextPhotoView.layer.opacity = 0
        
        let likeGR = UITapGestureRecognizer(target: self, action: #selector(heartStateChanged))
        likeGR.numberOfTapsRequired = 2
        photoFullScreenView.addGestureRecognizer(likeGR)
        
        let flipLeftGR = UISwipeGestureRecognizer(target: self, action: #selector (flipLeftPhotos))
        flipLeftGR.direction = .left
        photoFullScreenView.addGestureRecognizer(flipLeftGR)
        
        let flipRightGR = UISwipeGestureRecognizer(target: self, action: #selector(flipRightPhotos))
        flipRightGR.direction = .right
        photoFullScreenView.addGestureRecognizer(flipRightGR)
        
    }
    
    @objc func flipRightPhotos(){
        compression()
        decompression()
        reloadInputViews()
        
        
    }
    
    @objc func flipLeftPhotos(){
        guard index != (photos.count - 1)
            else { return }
        index += 1
        photoFullScreenView.image = photos[index]
        compression()
        decompression()
    }
    
    
    
    @objc private func heartStateChanged(){
        likeImageView.isHeartFilled.toggle()
        if likeCountView.text == String(likeCount){
            likeCountUp(String(likeCount + 1))
        } else {
            likeCountDown(String(likeCount))
        }
    }
    
    //MARK: - Animation
    private func likeCountUp(_ text: String) {
        UIView.transition(with: likeCountView, duration: 0.4, options: .transitionFlipFromRight, animations: {
        self.likeCountView.text = text
        })
    }
    
    private func likeCountDown(_ text: String) {
        UIView.transition(with: likeCountView, duration: 0.4, options: .transitionFlipFromLeft, animations: {
            self.likeCountView.text = text
        })
    }
    
    @objc func compression() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.photoFullScreenView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.photoFullScreenView.frame = self.photoFullScreenView.frame.offsetBy(dx: self.view.frame.width, dy: 0)
            }, completion: nil ) })}
    
    private func decompression() {
        guard index != 0
            else { return }
        index -= 1
        nextPhotoView.image = photos[index]
        nextPhotoView.layer.opacity = 1
        nextPhotoView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        nextPhotoView.frame = nextPhotoView.frame.offsetBy(dx: -(self.view.frame.width), dy: 0)
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveLinear, animations: {
                self.nextPhotoView.frame = self.photoFullScreenView.frame.offsetBy(dx: 0, dy: 0)
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                    self.nextPhotoView.transform = CGAffineTransform.identity
                }, completion: { _ in
                    self.photoFullScreenView.image = self.photos[self.index]
                    print(self.index)
                    self.photoFullScreenView.transform = CGAffineTransform.identity
                    self.nextPhotoView.layer.opacity = 0
                    
                }) })
    }
    
}
