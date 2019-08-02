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
    
    @objc private func heartStateChanged(){
        likeImageView.isHeartFilled.toggle()
        if likeCountView.text == String(likeCount){
            likeCountUp(String(likeCount + 1))
        } else {
            likeCountDown(String(likeCount))
        }
    }
    
    //MARK: - Animation
    @objc func flipRightPhotos(){
        if index > 0 {
            UIView.animateKeyframes(withDuration: 3,
                                    delay: 0,
                                    options: [],
                                    animations: {
                                        UIView.addKeyframe(withRelativeStartTime: 0,
                                                           relativeDuration: 0.25,
                                                           animations: {
                                                            self.photoFullScreenView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                           relativeDuration: 0.5,
                                                           animations: {
                                                            self.photoFullScreenView.frame = self.photoFullScreenView.frame.offsetBy(dx: self.view.frame.width, dy: 0)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.2,
                                                           relativeDuration: 0,
                                                           animations: {
                                                            let nextIndex = self.index - 1
                                                            self.nextPhotoView.image = self.photos[nextIndex]
                                                            self.nextPhotoView.layer.opacity = 1
                                                            self.nextPhotoView.frame = self.nextPhotoView.frame.offsetBy(dx: -(self.view.frame.width), dy: 0)
                                                            self.nextPhotoView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                           relativeDuration: 0.5,
                                                           animations: {
                                                            self.nextPhotoView.frame = self.nextPhotoView.frame.offsetBy(dx: self.view.frame.width, dy: 0)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.75,
                                                           relativeDuration: 0.25,
                                                           animations: {
                                                            self.nextPhotoView.transform = CGAffineTransform.identity
                                        })
                                        
                                        }, completion: { _ in
                                            self.index -= 1
                                            self.photoFullScreenView.image = self.photos[self.index]
                                            self.photoFullScreenView.transform = CGAffineTransform.identity
                                            self.nextPhotoView.layer.opacity = 0
                                            self.view.setNeedsDisplay()
            })
        } else { return }
    }
    
    @objc func flipLeftPhotos(){
        if index < (photos.count - 1) {
            UIView.animateKeyframes(withDuration: 3,
                                    delay: 0,
                                    options: [],
                                    animations: {
                                        UIView.addKeyframe(withRelativeStartTime: 0,
                                                           relativeDuration: 0.25,
                                                           animations: {
                                                            self.photoFullScreenView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                           relativeDuration: 0.5,
                                                           animations: {
                                                            self.photoFullScreenView.frame = self.photoFullScreenView.frame.offsetBy(dx: -(self.view.frame.width), dy: 0)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0,
                                                           relativeDuration: 0,
                                                           animations: {
                                                            let nextIndex = self.index + 1
                                                            self.nextPhotoView.image = self.photos[nextIndex]
                                                            self.nextPhotoView.layer.opacity = 1
                                                            self.nextPhotoView.frame = self.nextPhotoView.frame.offsetBy(dx: self.view.frame.width, dy: 0)
                                                            self.nextPhotoView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                           relativeDuration: 0.5,
                                                           animations: {
                                                            self.nextPhotoView.frame = self.nextPhotoView.frame.offsetBy(dx: -(self.view.frame.width), dy: 0)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.75,
                                                           relativeDuration: 0.25,
                                                           animations: {
                                                            self.nextPhotoView.transform = CGAffineTransform.identity
                                        })
                                        }, completion: { _ in
                                            self.index += 1
                                            self.photoFullScreenView.image = self.photos[self.index]
                                            self.photoFullScreenView.transform = CGAffineTransform.identity
                                            self.nextPhotoView.layer.opacity = 0
                                            self.photoFullScreenView.setNeedsDisplay()
            })
        } else { return }
    }
    
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
}
