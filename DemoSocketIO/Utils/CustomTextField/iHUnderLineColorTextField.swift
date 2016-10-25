//
//  iHUnderLineColorTextField.swift
//  DemoSocketIO
//
//  Created by Đinh Xuân Lộc on 10/21/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

@IBDesignable open class iHUnderLineColorTextField: TextFieldEffects {
    
    /**
     The color of the border when it has no content.
     
     This property applies a color to the lower edge of the control. The default value for this property is a clear color.
     */
    @IBInspectable dynamic open var borderInactiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    /**
     The color of the border when it has content.
     
     This property applies a color to the lower edge of the control. The default value for this property is a clear color.
     */
    @IBInspectable dynamic open var borderActiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    /**
     The color of the placeholder text.
     This property applies a color to the complete placeholder string. The default value for this property is a black color.
     */
    @IBInspectable dynamic open var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
     */
    @IBInspectable dynamic open var placeholderFontScale: CGFloat = 0.65 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
            updatePlaceholder()
        }
    }
    
    public var validationRuleSet: ValidationRuleSet<String>? = ValidationRuleSet<String>() {
        didSet { self.validationRules = validationRuleSet }
    }
   

    
    private let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5)
    private let placeholderInsets = CGPoint(x: 0, y: 6)
    private let textFieldInsets = CGPoint(x: 0, y: 12)
    private let inactiveBorderLayer = CALayer()
    private let activeBorderLayer = CALayer()
    private var activePlaceholderPoint: CGPoint = CGPoint.zero
    private let checkbox:M13Checkbox =  M13Checkbox(frame: CGRect(x: 0.0, y: 0.0, width: 32, height: 32))
    
    
    // MARK: - TextFieldsEffects
    override open func drawViewsForRect(_ rect: CGRect) {
        self.rightViewMode = .always
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateBorder()
        updatePlaceholder()

        checkbox.isUserInteractionEnabled = false
        checkbox.contentMode = .center

        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
        addSubview(placeholderLabel)
        
        self.rightView = checkbox
        self.rightView?.contentMode = .center
    }

    
    override open func animateViewsForTextEntry() {
        updateBorder()
        if text!.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: ({
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                self.placeholderLabel.alpha = 0
            }), completion: { _ in
                self.animationCompletionHandler?(.textEntry)
            })
        }
        
        layoutPlaceholderInTextRect()
        placeholderLabel.frame.origin = activePlaceholderPoint
        
        UIView.animate(withDuration: 0.2, animations: {
            self.placeholderLabel.alpha = 0.5
        })
        
        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: true)
    }
    
    override open func animateViewsForTextDisplay() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.alpha = 1
            }), completion: { _ in
                self.animationCompletionHandler?(.textDisplay)
            })
            
            activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFilled: false)
        }
    }
    
    // MARK: - Private
    
    public func updateBorder() {
        switch valid {
        case 1:
            checkbox.isHidden = false
            if checkbox.checkState != .checked{
                checkbox.toggleCheckState(true)
            }
            
            inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
            inactiveBorderLayer.backgroundColor = borderInactiveColor?.cgColor
            
            activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
            activeBorderLayer.backgroundColor = UIColor.green.cgColor
        case 0:
            if checkbox.checkState == .checked{
                checkbox.toggleCheckState(true)
            }
            checkbox.isHidden = true
            inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
            inactiveBorderLayer.backgroundColor = borderInactiveColor?.cgColor
            
            activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
            activeBorderLayer.backgroundColor = UIColor.red.cgColor
        default:
            if checkbox.checkState == .checked{
                checkbox.toggleCheckState(true)
            }
            checkbox.isHidden = true
            inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
            inactiveBorderLayer.backgroundColor = borderInactiveColor?.cgColor
            
            activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
            activeBorderLayer.backgroundColor = borderActiveColor?.cgColor
        }
        
    }
    
    public func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder || text!.isNotEmpty {
            animateViewsForTextEntry()
        }
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    private func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        if isFilled {
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: 0, height: thickness))
        }
    }
    
    private func layoutPlaceholderInTextRect() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch self.textAlignment {
        case .center:
            originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        placeholderLabel.frame = CGRect(x: originX, y: textRect.height/2,
                                        width: placeholderLabel.bounds.width, height: placeholderLabel.bounds.height)
        activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
        
    }
    
    // MARK: - Overrides
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: textFieldInsets.x, y: textFieldInsets.y, width: bounds.size.width - checkbox.frame.width, height: bounds.size.height)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }

}