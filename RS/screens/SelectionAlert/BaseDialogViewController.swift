//
//  BaseDialogViewController.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

class BaseDialogViewController: UIViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.transitioningDelegate = self
    }
    
}


extension BaseDialogViewController: UIViewControllerTransitioningDelegate{
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(withDuration: 0.5, forTransitionType: .Dismissing, originFrame: self.view.frame)
    }
    
    func animationController(forPresented presented: UIViewController,presenting: UIViewController, source: UIViewController)
        -> UIViewControllerAnimatedTransitioning?{
            return AnimationController(withDuration: 0.5, forTransitionType: .Presenting, originFrame: self.view.frame)
    }
    
}
