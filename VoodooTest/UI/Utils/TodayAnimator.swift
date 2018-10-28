//
//  TodayAnimator.swift
//  VoodooTest
//
//  Created by Martreux Steven on 27/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation
import UIKit

final class TodayAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var initialFrame: CGRect!
    var isPresenting: Bool = false
        
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let todayDetailController = (isPresenting ? transitionContext.viewController(forKey: .to) : transitionContext.viewController(forKey: .from)) as? TodayDetailViewController else { return }

        let todayView: UIView = isPresenting ? transitionContext.view(forKey: .to)! : transitionContext.view(forKey: .from)!
        containerView.addSubview(todayView)
        containerView.bringSubviewToFront(todayView)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
            if self.isPresenting {
                todayDetailController.willPresentView()
            } else {
                todayDetailController.willDismissView()
            }
        }) { (_) in
            if  transitionContext.transitionWasCancelled {
                todayView.removeFromSuperview()
                todayView.frame = self.initialFrame
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
