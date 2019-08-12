//
//  Custom.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 18/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//


import UIKit

@IBDesignable
class LikeImageView: UIControl {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public var isHeartFilled = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    public var heartColor:UIColor = .red
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setFillColor(UIColor.red.cgColor)
        context.saveGState()
        
        heart.stroke()
        
        if isHeartFilled {
            context.setStrokeColor(UIColor.red.cgColor)
            heart.stroke()
            heart.fill()
        }
        
    }
    
    let heart: UIBezierPath = {
        let heart = UIBezierPath()
        let rect = CGRect(x: 0, y: 0, width: 30, height: 30)
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
        
        heart.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: CGFloat(arcRadius), startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        heart.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
        heart.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: CGFloat(arcRadius), startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        heart.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        heart.close()
        
        return heart
    }()
    
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

