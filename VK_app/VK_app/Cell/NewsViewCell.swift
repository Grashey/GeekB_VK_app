//
//  NewsViewCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 25/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var likeImageView: LikeImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var repostImageView: UIImageView!
    @IBOutlet weak var repostCountLabel: UILabel!
    
    @IBOutlet weak var viewCountImageView: UIImageView!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    var likeCount = 0
    var commentCount = 0
    var repostCount = 0
    var viewsCount = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeCountLabel.textColor = .lightGray
        likeCountLabel.text = String(likeCount)
        commentCountLabel.text = String(commentCount)
        repostCountLabel.text = String(repostCount)
        viewCountLabel.text = String(viewsCount)
        
        let likeGR = UITapGestureRecognizer(target: self, action: #selector(heartStateChanged))
        likeImageView.addGestureRecognizer(likeGR)
        
        let commentGR = UITapGestureRecognizer(target: self, action: #selector(commentStateChanged))
        commentImageView.addGestureRecognizer(commentGR)
        
        let repostGR = UITapGestureRecognizer(target: self, action: #selector(repostStateChanged))
        repostImageView.addGestureRecognizer(repostGR)
        
        let viewGR = UITapGestureRecognizer(target: self, action: #selector(viewCountStateChanged))
        viewCountImageView.addGestureRecognizer(viewGR)
    }
    
    @objc private func heartStateChanged(){
        likeImageView.isHeartFilled.toggle()
        if likeCountLabel.text == String(likeCount){
            flipCountUp(likeCountLabel, String(likeCount + 1))
            likeCountLabel.textColor = .red
        } else {
            flipCountDown(likeCountLabel, String(likeCount))
            likeCountLabel.textColor = .lightGray
        }
    }
    
    @objc private func commentStateChanged(){
        flipCountUp(commentCountLabel, String(commentCount + 1))
        commentCount += 1
    }
    
    @objc private func repostStateChanged(){
        flipCountUp(repostCountLabel, String(repostCount + 1))
        repostCount += 1
    }
    
    @objc private func viewCountStateChanged(){
        if viewCountLabel.text == String(viewsCount){
            flipCountUp(viewCountLabel, String(viewsCount + 1))
        } else { return }
    }
    
    //MARK: - Animation
    private func flipCountUp(_ label: UILabel, _ text: String) {
        UIView.transition(with: label, duration: 0.4, options: .transitionFlipFromRight, animations: {
            label.text = text
        })
    }
    
    private func flipCountDown(_ label: UILabel, _ text: String) {
        UIView.transition(with: label, duration: 0.4, options: .transitionFlipFromLeft, animations: {
            label.text = text
        })
    }
}
