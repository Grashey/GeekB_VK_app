//
//  PhotoViewController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 16/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import RealmSwift
@IBDesignable

class PhotoViewController: UIViewController {
   
    @IBOutlet weak var photoFullScreenView: UIImageView!
    @IBOutlet weak var likeCountView: UILabel!
    @IBOutlet var likeImageView: LikeImageView!
    @IBOutlet weak var nextPhotoView: UIImageView!
    
    var likeCount = 0
    var index = Int()
    var photos = [Photo]()
    
    override func viewDidLoad() {
        
        let photos = try? RealmService.getData(type: Photo.self)
        photos?.forEach{ photo in
            self.photos.append(photo)
        }
        
        likeCountView.textColor = .lightGray
        let imageUrl = URL(string: self.photos[index].photoMaxUrl)
        photoFullScreenView.kf.setImage(with: imageUrl)
        likeCountView.text = String(likeCount)
        nextPhotoView.isHidden = true
        
        let likeGR = UITapGestureRecognizer(target: self, action: #selector(heartStateChanged))
        likeGR.numberOfTapsRequired = 2
        photoFullScreenView.addGestureRecognizer(likeGR)
        
        let flipLeftGR = UISwipeGestureRecognizer(target: self, action: #selector (flipLeftPhotos))
        flipLeftGR.direction = .left
        photoFullScreenView.addGestureRecognizer(flipLeftGR)
        
        let flipRightGR = UISwipeGestureRecognizer(target: self, action: #selector(flipRightPhotos))
        flipRightGR.direction = .right
        photoFullScreenView.addGestureRecognizer(flipRightGR)
        
        let closeGR = UISwipeGestureRecognizer(target: self, action: #selector(closePhoto))
        closeGR.direction = .down
        photoFullScreenView.addGestureRecognizer(closeGR)
    }
    
    //MARK: - Animation
    @objc private func heartStateChanged(){
        likeImageView.isHeartFilled.toggle()
        if likeCountView.text == String(likeCount){
            likeCountUp(String(likeCount + 1))
            likeCountView.textColor = .red
        } else {
            likeCountDown(String(likeCount))
            likeCountView.textColor = .lightGray
        }
    }
    
    @objc func flipRightPhotos(){
        guard index > 0 else { return }
        
        let scaleTransform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        let goLeftTransform = CGAffineTransform.init(translationX: -view.bounds.width, y: 0)
        let goRightTransform = CGAffineTransform.init(translationX: view.bounds.width, y: 0)
        
        let nextIndex = self.index - 1
        let nextImageUrl = URL(string: photos[nextIndex].photoMaxUrl)
        self.nextPhotoView.kf.setImage(with: nextImageUrl)
        self.nextPhotoView.isHidden = false
        self.nextPhotoView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8).concatenating(goLeftTransform)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.25,
                               animations: {
                                self.photoFullScreenView.transform = scaleTransform
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25,
                               relativeDuration: 0.5,
                               animations: {
                                self.photoFullScreenView.transform = scaleTransform.concatenating(goRightTransform)
                                self.nextPhotoView.transform = scaleTransform
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75,
                               relativeDuration: 0.25,
                               animations: {
                                self.nextPhotoView.transform = .identity
            })
        }, completion: { _ in
            self.nextPhotoView.isHidden = true
            self.index -= 1
            let imageUrl = URL(string: self.photos[self.index].photoMaxUrl)
            self.photoFullScreenView.kf.setImage(with: imageUrl)
            self.photoFullScreenView.transform = .identity
        })
    }
    
    @objc func flipLeftPhotos(){
        guard index < (photos.count - 1) else { return }
        
        let scaleTransform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        let goLeftTransform = CGAffineTransform.init(translationX: -view.bounds.width, y: 0)
        let goRightTransform = CGAffineTransform.init(translationX: view.bounds.width, y: 0)
        
        let nextIndex = self.index + 1
        let nextImageUrl = URL(string: photos[nextIndex].photoMaxUrl)
        self.nextPhotoView.kf.setImage(with: nextImageUrl)
        self.nextPhotoView.isHidden = false
        self.nextPhotoView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8).concatenating(goRightTransform)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.25,
                               animations: {
                                self.photoFullScreenView.transform = scaleTransform
                                        })
            UIView.addKeyframe(withRelativeStartTime: 0.25,
                               relativeDuration: 0.5,
                               animations: {
                                self.photoFullScreenView.transform = scaleTransform.concatenating(goLeftTransform)
                                self.nextPhotoView.transform = scaleTransform
                                        })
            UIView.addKeyframe(withRelativeStartTime: 0.75,
                               relativeDuration: 0.25,
                               animations: {
                                self.nextPhotoView.transform = .identity
                                        })
        }, completion: { _ in
            self.nextPhotoView.isHidden = true
            self.index += 1
            let imageUrl = URL(string: self.photos[self.index].photoMaxUrl)
            self.photoFullScreenView.kf.setImage(with: imageUrl)
            self.photoFullScreenView.transform = .identity
            })
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
    
    @objc func closePhoto(){
        UIView.animate(withDuration: 0.5,
                       animations: {
                      self.photoFullScreenView.transform = CGAffineTransform.init(translationX: 0, y: self.view.bounds.height)
        },
                       completion: { _ in
                        self.navigationController?.popViewController(animated: false)
        })
    }
}
