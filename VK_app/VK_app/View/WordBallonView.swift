//
//  WordBallonView.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 13/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class WordBallonView: UIControl {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setFillColor(UIColor.white.cgColor)
        context.saveGState()
        
        wordBallon.stroke()
        wordBallon.fill()
    }
    
    let wordBallon: UIBezierPath = {
        let ballonrightpart = UIBezierPath()
        let ballonleftpart = UIBezierPath()
        
        ballonrightpart.move(to: CGPoint(x: 100, y: 100))
        ballonrightpart.addQuadCurve(to: CGPoint(x: 90, y: 80), controlPoint: CGPoint(x: 90, y: 100))
        ballonrightpart.addCurve(to: CGPoint(x: 90, y: 20), controlPoint1: CGPoint(x: 140, y: 60), controlPoint2: CGPoint(x: 140, y: 40))
        ballonrightpart.addQuadCurve(to: CGPoint(x: 50, y: 20), controlPoint: CGPoint(x: 70, y: 10))
        
        ballonleftpart.move(to: CGPoint(x: 100, y: 100))
        ballonleftpart.addQuadCurve(to: CGPoint(x: 75, y: 80), controlPoint: CGPoint(x: 90, y: 100))
        ballonleftpart.addCurve(to: CGPoint(x: 50, y: 20), controlPoint1: CGPoint(x: 10, y: 70), controlPoint2: CGPoint(x: 0, y: 40))
        
        ballonrightpart.append(ballonleftpart)
        
        return ballonrightpart
    }()
}


