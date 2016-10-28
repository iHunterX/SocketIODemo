//
//  UIViewExtensions.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 10/28/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

//class UIViewBorder: UIView {
extension UIView {


    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var leftBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = UIColor(cgColor: layer.borderColor!)
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    
    @IBInspectable var topBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        }
    }
    
    @IBInspectable var rightBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var bottomBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        }
    }
    //    @IBInspectable dynamic open var borderColor: UIColor = .lightGray
    //    @IBInspectable dynamic open var thickness: CGFloat = 1
    //
    //    @IBInspectable dynamic open var topBorder: Bool = false {
    //        didSet {
    //            addBorder(edge: .top)
    //        }
    //    }
    //    @IBInspectable dynamic open var bottomBorder: Bool = false {
    //        didSet {
    //            addBorder(edge: .bottom)
    //        }
    //    }
    //    @IBInspectable dynamic open var rightBorder: Bool = false {
    //        didSet {
    //            addBorder(edge: .right)
    //        }
    //    }
    //    @IBInspectable dynamic open var leftBorder: Bool = false {
    //        didSet {
    //            addBorder(edge: .left)
    //        }
    //    }
    //    enum
    //    //decalare a private topBorder
    //    func addTopBorderWithColor(color: UIColor, thickness: CGFloat) {
    //        let border = CALayer()
    //        border.backgroundColor = color.cgColor
    //        border.frame = CGRect(x:0,y: 0,width: self.frame.size.width,height: thickness)
    //        self.layer.addSublayer(border)
    //    }
    //    func addTopBorderWithColor(color: UIColor, thickness: CGFloat) {
    //        let border = CALayer()
    //        border.backgroundColor = color.cgColor
    //        border.frame = CGRect(x:0,y: 0,width: self.frame.size.width,height: thickness)
    //        self.layer.addSublayer(border)
    //    }
    //
    //    func addRightBorderWithColor(color: UIColor, thickness: CGFloat) {
    //        let border = CALayer()
    //        border.backgroundColor = color.cgColor
    //        border.frame = CGRect(x:self.frame.size.width - thickness,y: 0,width: width,height: self.frame.size.height)
    //        self.layer.addSublayer(border)
    //    }
    //
    //    func addBottomBorderWithColor(color: UIColor, thickness: CGFloat) {
    //        let border = CALayer()
    //        border.backgroundColor = color.cgColor
    //        border.frame = CGRect(x:0,y: self.frame.size.height - thickness,width: self.frame.size.width,height: thickness)
    //        self.layer.addSublayer(border)
    //    }
    //
    //    func addLeftBorderWithColor(color: UIColor, thickness: CGFloat) {
    //        let border = CALayer()
    //        border.backgroundColor = color.cgColor
    //        border.frame = CGRect(x:0,y: 0,width: thickness,height: self.frame.size.height)
    //        self.layer.addSublayer(border)
    //    }

}
