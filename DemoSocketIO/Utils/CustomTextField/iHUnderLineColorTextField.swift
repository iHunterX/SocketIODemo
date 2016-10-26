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
    @IBInspectable dynamic open var borderValidColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    @IBInspectable dynamic open var borderInvalidColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    @IBInspectable dynamic open var borderActiveValidColor: UIColor? {
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
    private let checkbox:M13Checkbox =  M13Checkbox()
    
    
    // MARK: - TextFieldsEffects
    override open func drawViewsForRect(_ rect: CGRect) {
        backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.rightViewMode = .always
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        let checkBoxHeight = self.frame.size.height - 20
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateBorder()
        updatePlaceholder()
        setupCheckBox(checkBoxHeight)

        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
        addSubview(placeholderLabel)
        
    }
    
    func setupCheckBox(_ checkBoxHeight:CGFloat = 25){
        checkbox.isUserInteractionEnabled = false
        checkbox.frame = (frame: CGRect(x: 0.0, y: 0.0, width: checkBoxHeight, height: checkBoxHeight))
        checkbox.animationDuration = 0.5 
        checkbox.boxLineWidth = 2
        checkbox.checkmarkLineWidth = 2
        checkbox.stateChangeAnimation = .spiral
        checkbox.tintColor = borderValidColor
        rightView = checkbox
        rightView?.contentMode = .bottom
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
        else{
            updateBorder()
        }
        
        layoutPlaceholderInTextRect()
        placeholderLabel.frame.origin = activePlaceholderPoint
        
        UIView.animate(withDuration: 0.2, animations: {
            self.placeholderLabel.alpha = 0.5
        })
        
        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: true)
    }
    
    override open func animateViewsForTextDisplay() {
        updateBorder()
        if text!.isEmpty {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.alpha = 1
            }), completion: { _ in
                self.animationCompletionHandler?(.textDisplay)
            })
            
            activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFilled: false)
        }else {
            updateBorder()
        }
    }
    
    // MARK: - Private
    
    override open func updateBorder() {
        switch valid {
        case 1:
            checkbox.isHidden = false
            if checkbox.checkState != .checked{
                checkbox.toggleCheckState(true,isHidden: false)
            }
            
            
            inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
            inactiveBorderLayer.backgroundColor = borderValidColor?.cgColor
            
            activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
            activeBorderLayer.backgroundColor = borderValidColor?.cgColor
        case 0:
            if checkbox.checkState == .checked{
                checkbox.toggleCheckState(true,isHidden: false)
            }
            
            inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
            inactiveBorderLayer.backgroundColor = borderInvalidColor?.cgColor
            
            activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
            activeBorderLayer.backgroundColor = borderInvalidColor?.cgColor
        default:
            checkbox.isHidden = true
            if checkbox.checkState == .checked{
                checkbox.toggleCheckState(true)
            }
            inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
            inactiveBorderLayer.backgroundColor = borderInactiveColor?.cgColor
            
            activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
            activeBorderLayer.backgroundColor = borderActiveColor?.cgColor
        }
        
    }
    
    public func updatePlaceholder() {
        updateBorder()
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
        if checkbox.isHidden{
            return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y - 5)
        }else{
            return CGRect(x: textFieldInsets.x, y: textFieldInsets.y - 5, width: bounds.size.width - checkbox.frame.width, height: bounds.size.height)
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y - 5)
    }

}
