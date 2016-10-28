//
//  PaddingTextField.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 10/28/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    @IBInspectable dynamic open var paddingLeft: CGFloat = 10

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.width - 5, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft  , y: bounds.origin.y, width: bounds.width - 5, height: bounds.height)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft + 2 , y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

}
