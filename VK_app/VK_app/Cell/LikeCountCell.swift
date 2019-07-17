//
//  LikeCountCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 17/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class LikeCountCell: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.red.cgColor)
                
        //Calculate Radius of Arcs using Pythagoras
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
                
        //Left Hand Curve
        context.addArc(center: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: false)
                
        //Top Centre Dip
        context.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
                
        //Right Hand Curve
        context.addArc(center: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: false)
                
        //Right Bottom Line
        context.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
                
        //Left Bottom Line
        context.closePath()
    
        context.strokePath()
        
    }
}


