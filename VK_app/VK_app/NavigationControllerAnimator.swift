//
//  NavigationControllerAnimator.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 05/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class PushAnimator:  NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source  = transitionContext.viewController(forKey: .from),
            let destination =  transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.position = CGPoint(x: source.view.bounds.width, y: 0)
        
        destination.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        
        
        UIView.animate(withDuration: animationDuration, animations: {
            destination.view.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class PopAnimator:  NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source  = transitionContext.viewController(forKey: .from),
            let destination =  transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.addSubview(source.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        
        UIView.animate(withDuration: animationDuration, animations: {
            source.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2).concatenating( CGAffineTransform.init(translationX: source.view.bounds.width, y: 0))
            
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
