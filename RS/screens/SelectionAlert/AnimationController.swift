//
//  AnimationController.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

enum TransitionType {
    case Presenting, Dismissing
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    
    
    init(withDuration duration: TimeInterval, forTransitionType type: TransitionType, originFrame: CGRect) {
        self.duration = duration
        self.isPresenting = type == .Presenting
        self.originFrame = originFrame
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let containerView = transitionContext.containerView
            containerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        let targetView = self.isPresenting ? toView : fromView
        
    
        if( isPresenting){
            containerView.addSubview(targetView!)
        }
        
      
        self.animate(view: targetView!,value: CGFloat(self.isPresenting ? 0.1 : 1.0))
        
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            self.animate(view: targetView!, value: CGFloat(self.isPresenting ? 1.0 : 0.1))
        }) { (completed: Bool) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
    fileprivate func animate(view: UIView, value: CGFloat){
        view.transform = CGAffineTransform(scaleX: value, y: value)
        view.layoutIfNeeded()
    }
    
}
