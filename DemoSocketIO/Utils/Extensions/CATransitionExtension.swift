//
//  CATransitionExtension.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/4/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import Foundation

enum transitionType: String{
    case kCATransitionFade
    
    case kCATransitionMoveIn
    
    case kCATransitionPush
    
    case  kCATransitionReveal
    
    /* Common transition subtypes. */
    
    case kCATransitionFromRight
    
    case kCATransitionFromLeft
    
    case kCATransitionFromTop
    
    case kCATransitionFromBottom
}

enum CAMediaRimingFuntionName:String{
    case kCAMediaTimingFunctionLinear = "kCAMediaTimingFunctionLinear"
    
    case kCAMediaTimingFunctionEaseIn = "kCAMediaTimingFunctionEaseIn"
    
    case kCAMediaTimingFunctionEaseOut = "kCAMediaTimingFunctionEaseOut"
    
    case kCAMediaTimingFunctionEaseInEaseOut = "kCAMediaTimingFunctionEaseInEaseOut"
    
    case kCAMediaTimingFunctionDefault = "kCAMediaTimingFunctionDefault"
}

extension CATransition{
    func transitionType(navigationController: UINavigationController,pushTo:UIViewController, transType: UINavigationControllerOperation,animationType: transitionType, duration: Float, timingFunction:CAMediaRimingFuntionName,timingFunctionName: CAMediaRimingFuntionName, animated:Bool){
        let transition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.timingFunction = CAMediaTimingFunction(name: timingFunction.rawValue)
        transition.type = animationType.rawValue
        navigationController.view.layer.add(transition, forKey: nil)
        switch transType {
        case .push:
         navigationController.pushViewController(pushTo, animated: animated)
        case .pop:
         navigationController.pop
            
        default:
            <#code#>
        }
    }
    
    
    
}

