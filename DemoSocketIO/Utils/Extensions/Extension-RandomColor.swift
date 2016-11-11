//
//  Extension-RandomColor.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/10/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import Foundation

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
