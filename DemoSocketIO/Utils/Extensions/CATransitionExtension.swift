//
//  CATransitionExtension.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/4/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import Foundation

extension UIView{
    func transitionType(navigationController: UINavigationController,pushTo:UIViewController?, transType: UINavigationControllerOperation,animationType: String,animationSubType: String?, duration: Float, animated:Bool = false){
        
        navigationController.view.layer.removeAnimation(forKey: kCATransition)
        let transition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = animationType
        transition.subtype = animationSubType
        navigationController.view.layer.add(transition, forKey: kCATransition)
        switch transType {
            
        case .push:
            if  pushTo !=  nil {
                navigationController.pushViewController(pushTo!, animated: animated)
            }
            
        case .pop:
            navigationController.popToRootViewController(animated: animated)
            
        case .none:
            if  pushTo !=  nil {
                navigationController.present(pushTo!, animated: animated, completion: nil)
            }
            
        }
    }
}

