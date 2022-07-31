//
//  BaseDialogViewController.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

class BaseDialogViewController: UIViewController {

    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(nibName: String?, bundle: Bundle?){
        super.init(nibName: nibName, bundle: bundle)

        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.automatic
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
