//
//  SlideinPresentationManager.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/3/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//
import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class SlideinPresentationManager: NSObject {
    var direction = PresentationDirection.left
}

extension SlideinPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented,
                                                                   presenting: presenting,
                                                                   direction: direction)
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    }
}
