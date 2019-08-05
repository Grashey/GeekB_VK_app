//
//  NavigationControllerAnimator.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 05/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class Animator:  NSObject, UIViewControllerAnimatedTransitioning {
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
        
        destination.view.transform = CGAffineTransform(translationX: 0, y: -source.view.bounds.height)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destination.view.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    
}
