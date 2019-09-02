//
//  AnimatedNavigationController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

class AnimatedNavigationController: UINavigationController {
    
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        transitioningDelegate = self
        
        let edgePanGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        edgePanGR.edges = .left
        view.addGestureRecognizer(edgePanGR)
    }
    
    @objc func handlePanGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
            
        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.35
            
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
            
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()

        default:
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

extension AnimatedNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimator()
        case .pop:
            return PopAnimator()
        default:
            return nil
        }
    }
}

extension AnimatedNavigationController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushAnimator()
    }
}
