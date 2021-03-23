//
//  UIViewExtension.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/23.
//


import UIKit


extension UIView {
    func fadeOut(duration: TimeInterval = 0.2, completeHandler:@escaping () -> ()) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { [weak self] (finished: Bool) -> Void in
            completeHandler()
        })
    }
    
    func slidePush(duration: TimeInterval = 0.2, completionDelegate: AnyObject? = nil, direction: CATransitionSubtype, completeHandler:@escaping () -> ()) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 1.0
        }, completion: { [weak self] (finished: Bool) -> Void in
            completeHandler()
        })
        let slidePushTransition = CATransition()
        if let delegate: AnyObject = completionDelegate {
            slidePushTransition.delegate = delegate as? CAAnimationDelegate
        }
        slidePushTransition.type = CATransitionType.push
        slidePushTransition.subtype = direction
        slidePushTransition.duration = duration
        slidePushTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        slidePushTransition.fillMode = CAMediaTimingFillMode.removed
        slidePushTransition.startProgress = 0.8
        self.layer.add(slidePushTransition, forKey: "slidePushTransition")
    }
}

