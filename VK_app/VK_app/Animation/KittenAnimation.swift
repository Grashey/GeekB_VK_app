//
//  KittenAnimation.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 19.12.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class KittenAnimation {
    
    func kittenMeowing(kittenHead: UIImageView, kittenPaws: UIImageView, wordBallon: UIView, meowLabel: UILabel){
        kittenHead.transform = CGAffineTransform.init(translationX: 0, y: kittenHead.frame.height)
        kittenPaws.transform = CGAffineTransform.init(translationX: 0, y: kittenPaws.frame.height)
        UIView.animate(withDuration: 1,
                       animations: { kittenPaws.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -kittenPaws.frame.height)
        },  completion: {_ in
        UIView.animate(withDuration: 2,
                       animations: { kittenHead.transform = CGAffineTransform.init(translationX: 0, y: -kittenPaws.frame.height)
        },  completion: {_ in
            self.wordBallonAppear(wordBallon: wordBallon)
        UIView.animate(withDuration: 2,
                       animations: { meowLabel.alpha = 1
        },  completion: nil )
        }) })
    }
    
    private let ballonrightpart: UIBezierPath = {
        let ballonrightpart = UIBezierPath()
        
        ballonrightpart.move(to: CGPoint(x: 100, y: 100))
        ballonrightpart.addQuadCurve(to: CGPoint(x: 90, y: 80), controlPoint: CGPoint(x: 90, y: 100))
        ballonrightpart.addCurve(to: CGPoint(x: 90, y: 20), controlPoint1: CGPoint(x: 140, y: 60), controlPoint2: CGPoint(x: 140, y: 40))
        ballonrightpart.addQuadCurve(to: CGPoint(x: 50, y: 20), controlPoint: CGPoint(x: 70, y: 10))
        
        return ballonrightpart
    }()
    
    private let ballonleftpart: UIBezierPath = {
        let ballonleftpart = UIBezierPath()

        ballonleftpart.move(to: CGPoint(x: 100, y: 100))
        ballonleftpart.addQuadCurve(to: CGPoint(x: 75, y: 80), controlPoint: CGPoint(x: 90, y: 100))
        ballonleftpart.addCurve(to: CGPoint(x: 50, y: 20), controlPoint1: CGPoint(x: 10, y: 70), controlPoint2: CGPoint(x: 0, y: 40))
        
        return ballonleftpart
    }()
    
    private func wordBallonAppear(wordBallon: UIView){
        let pointRightLayer = CAShapeLayer()
        pointRightLayer.path = ballonrightpart.cgPath
        pointRightLayer.lineWidth = 2
        pointRightLayer.strokeColor = UIColor.black.cgColor
        pointRightLayer.fillColor = UIColor.clear.cgColor
        pointRightLayer.strokeEnd = 1
        wordBallon.layer.addSublayer(pointRightLayer)
        
        let pointLeftLayer = CAShapeLayer()
        pointLeftLayer.path = ballonleftpart.cgPath
        pointLeftLayer.lineWidth = 2
        pointLeftLayer.strokeColor = UIColor.black.cgColor
        pointLeftLayer.fillColor = UIColor.clear.cgColor
        pointLeftLayer.strokeEnd = 1
        wordBallon.layer.addSublayer(pointLeftLayer)
        
        let appearAnimation = CABasicAnimation(keyPath: "strokeEnd")
        appearAnimation.duration = 2
        appearAnimation.fromValue = 0
        appearAnimation.toValue = 1
        
        pointRightLayer.add(appearAnimation, forKey: nil)
        pointLeftLayer.add(appearAnimation, forKey: nil)
    }
}
