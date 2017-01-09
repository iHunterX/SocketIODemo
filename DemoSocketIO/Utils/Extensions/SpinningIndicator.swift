//
//  SpinningIndicator.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/17/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//
//
//  SWActivityIndicatorView.swift
//  Pods
//
//  Created by Sarun Wongpatcharapakorn on 10/19/15.
//
//
import Foundation
import UIKit

private let SWSpinningAnimationKey = "Rotation"

@IBDesignable public class SWActivityIndicatorView: UIView {
    @IBInspectable public var lineWidth: CGFloat = 2 {
        didSet {
            self.circlePathLayer.lineWidth = lineWidth
        }
    }
    private(set) public var isAnimating = false
    @IBInspectable public var autoStartAnimating: Bool = false {
        didSet {
            if autoStartAnimating && self.superview != nil {
                self.animate(animated: true)
            }
        }
    }
    @IBInspectable public var hidesWhenStopped: Bool = false {
        didSet {
            
        }
    }
    @IBInspectable public var color: UIColor = UIColor.lightGray {
        didSet {
            self.circlePathLayer.strokeColor = color.cgColor
        }
    }
    
    private var circlePathLayer = CAShapeLayer()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.circlePathLayer.frame = bounds
        self.circlePathLayer.path = self.circlePath().cgPath
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview != nil {
            if self.autoStartAnimating {
                self.animate(animated: true)
            }
        } else {
            self.animate(animated: false)
        }
    }
    
    
    public func startAnimating() {
        self.animate(animated: true)
    }
    
    public func stopAnimating() {
        self.animate(animated: false)
    }
    
    private func animate(animated: Bool) {
        if animated {
            self.isHidden = false
            
            if self.isAnimating == false {
                // create or resume
                if self.circlePathLayer.animation(forKey: SWSpinningAnimationKey) == nil {
                    self.createAnimationLayer(layer: self.circlePathLayer)
                } else {
                    self.resumeLayer(layer: self.circlePathLayer)
                }
            }
            
            self.isAnimating = true
        } else {
            self.isAnimating = false
            self.pauseLayer(layer: self.circlePathLayer)
            if self.hidesWhenStopped {
                self.isHidden = true
            }
        }
    }
    
    private func pauseLayer(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    private func resumeLayer(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePaused = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePaused
    }
    
    private func createAnimationLayer(layer: CALayer) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: 2 * M_PI)
        animation.duration = 0.9;
        animation.isRemovedOnCompletion = false // prevent from getting remove when app enter background or view disappear
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: SWSpinningAnimationKey)
    }
    
    private func circleFrame() -> CGRect {
        // Align center
        let diameter = min(self.circlePathLayer.bounds.size.width, self.circlePathLayer.bounds.size.height)
        var circleFrame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        circleFrame.origin.x = circlePathLayer.bounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathLayer.bounds.midY - circleFrame.midY
        
        // offset lineWidth
        let inset = self.circlePathLayer.lineWidth / 2
        circleFrame = circleFrame.insetBy(dx: inset, dy: inset)
        
        return circleFrame
        
    }
    
    private func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: self.circleFrame())
    }
    
    private func configure() {
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = self.lineWidth
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = self.color.cgColor
        circlePathLayer.strokeEnd = 0.9
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.white
    }
    
    
}
