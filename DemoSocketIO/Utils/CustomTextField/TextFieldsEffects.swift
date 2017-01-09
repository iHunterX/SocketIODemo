//
//  TextFieldsEffects.swift
//  DemoSocketIO
//
//  Created by Đinh Xuân Lộc on 10/21/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit


@objc public protocol TextFieldEffectsDelegate: class {
    @objc optional func validTextField(valid: Bool)
}
extension String {
    /**
     true iff self contains characters.
     */
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

/**
 A TextFieldEffects object is a control that displays editable text and contains the boilerplates to setup unique animations for text entrey and display. You typically use this class the same way you use UITextField.
 */
open class TextFieldEffects : UITextField {
    
    
    weak open var tfdelegate:TextFieldEffectsDelegate?
    internal var valid = -1
    internal var failureMsgs:[String]? = nil
    open func updateValidationState(result: ValidationResult) {
        failureMsgs = nil
        switch result {
        case .valid:
            findUsernameAvailable(completionHandler: { (resultUserFinding,isErrorStr) in
                if isErrorStr == nil {
                    if resultUserFinding == true {
                        self.valid = 1
                        print("valid")
                        self.tfdelegate?.validTextField?(valid: true)
                        self.animateViewsForTextEntry()
                    }else{
                        print(resultUserFinding)
                        self.valid = 0
                        self.failureMsgs = ["Not Available"]
                        self.tfdelegate?.validTextField?(valid: false)
                        self.animateViewsForTextEntry()
                    }
                }
                else {
                    self.valid = 0
                    self.failureMsgs = [isErrorStr!]
                    self.tfdelegate?.validTextField?(valid: false)
                    self.animateViewsForTextEntry()
                }
            })
        case .invalid(let failures):
            let messages = failures.map { $0.message }
            failureMsgs = messages
            print(failureMsgs ?? "Error")
            valid = 0
            tfdelegate?.validTextField?(valid: false)
            animateViewsForTextEntry()
        }
    }
    
    open func findUsernameAvailable(completionHandler: @escaping (_ isAvailable:Bool,_ isErrorString:String?) -> Void){
        var isAvail:Bool = false
        let nickName = self.text!
        self.rightViewMode = .always
        self.rightView = spinningIndicator
        
        toggleAnimatingLoading(on: true)
        SocketIOManager.sharedInstance.findUserWithNickName(nickname: nickName) { (isAvailable,isErrorString) -> Void in
            if isErrorString == nil{
                isAvail = isAvailable
                self.toggleAnimatingLoading(on: false)
                completionHandler(isAvail,isErrorString)
            }else {
                isAvail = isAvailable
                self.toggleAnimatingLoading(on: false)
                completionHandler(isAvail,isErrorString)
            }
        }
    }
    
    func toggleAnimatingLoading(on:Bool) {
        if on {
            if spinningIndicator.isAnimating {
                spinningIndicator.stopAnimating()
                spinningIndicator.startAnimating()
            }else{
                spinningIndicator.startAnimating()
            }
        }
        else{
            if spinningIndicator.isAnimating {
                spinningIndicator.stopAnimating()
//                spinningIndicator.removeFromSuperview()
                self.rightView = nil
            }else{
//                spinningIndicator.removeFromSuperview()
                self.rightView = nil
            }
        }
    }
    
    /**
     The type of animatino a TextFieldEffect can perform.
     
     - TextEntry: animation that takes effect when the textfield has focus.
     - TextDisplay: animation that takes effect when the textfield loses focus.
     */
    public enum AnimationType: Int {
        case textEntry
        case textDisplay
    }
    
    
    open let spinningIndicator:SWActivityIndicatorView = SWActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    /**
     Closure executed when an animation has been completed.
     */
    public typealias AnimationCompletionHandler = (_ type: AnimationType)->()
    
    /**
     UILabel that holds all the placeholder information
     */
    open let placeholderLabel = UILabel()
    
    /**
     UILabel that holds all the error info
     */
    open let textfieldErrors = UILabel()
    /**
     Creates all the animations that are used to leave the textfield in the "entering text" state.
     */
    open var errorLabelTopConstraint = NSLayoutConstraint()
    open var errorLabelHeightConstraint = NSLayoutConstraint()
    open func animateViewsForTextEntry() {
        fatalError("\(#function) must be overridden")
    }
    
    /**
     Creates all the animations that are used to leave the textfield in the "display input text" state.
     */
    open func animateViewsForTextDisplay() {
        fatalError("\(#function) must be overridden")
    }
    
    open func animateForErrorDisplay(isError:Bool,errorMessage:[String]?) {
        fatalError("\(#function) must be overridden")
    }
    
    /**
     The animation completion handler is the best place to be notified when the text field animation has ended.
     */
    open var animationCompletionHandler: AnimationCompletionHandler?
    
    /**
     Draws the receiver’s image within the passed-in rectangle.
     
     - parameter rect:	The portion of the view’s bounds that needs to be updated.
     */
    open func drawViewsForRect(_ rect: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    
    open func updateViewsForBoundsChange(_ bounds: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    open func updateBorder() {
        fatalError("\(#function) must be overridden")
    }
    // MARK: - Overrides
    
    override open func draw(_ rect: CGRect) {
        drawViewsForRect(rect)
    }
    
    override open func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    override open var text: String? {
        didSet {
            if let text = text, text.isNotEmpty {
                animateViewsForTextEntry()
            } else {
                animateViewsForTextDisplay()
            }
        }
    }
    
    // MARK: - UITextField Observing
    
    override open func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(changing), name: NSNotification.Name.UITextFieldTextDidChange, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    /**
     The textfield has started an editing session.
     */
    open func textFieldDidBeginEditing() {
        self.validationHandler = {result in self.updateValidationState(result: result)}
        animateViewsForTextEntry()
        
    }
    open func changing() {
        self.validationHandler = {result in self.updateValidationState(result: result)}
    }
    
    /**
     The textfield has ended an editing session.
     */
    open func textFieldDidEndEditing() {
        self.validationHandler = {result in self.updateValidationState(result: result)}
        animateViewsForTextDisplay()
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
}



