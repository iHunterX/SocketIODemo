//
//  ViewController.swift
//  DemoSocketIO
//
//  Created by Đinh Xuân Lộc on 10/20/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit
import SocketIO



class ViewController: BaseViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var userNameTextField: iHUnderLineColorTextField!
    
    
    @IBOutlet weak var connectButton: UIButton!
    
    var isKeyboardHide = true
    var  tapGesture: UITapGestureRecognizer?
    
    
    var validationRuleSetUserName: ValidationRuleSet<String>? = ValidationRuleSet<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        userNameTextField.delegate = self
        userNameTextField.tfdelegate = self
        addTextFieldRules()
        connectButton.isEnabled = false
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    func tapScreen() {
        if !isKeyboardHide{
            self.view.endEditing(true)
        }
    }
    
    
    func keyboardWillShow(noti: Notification) {
        isKeyboardHide = false
        self.view.addGestureRecognizer(tapGesture!)
        
        guard let userInfo = noti.userInfo as? [String:Any] else {return}
        
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {return}
        
        guard let keyBoardValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyBoardRect = keyBoardValue.cgRectValue
        
        UIView.animate(withDuration: duration) { [weak self] in
            guard let strongSelf = self else {return}
            
            strongSelf.bottomOfViewSendMessage.constant = keyBoardRect.height
            
            strongSelf.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardRect.height + 40 , right: 0)
            
            
            strongSelf.scrollToBottomOfTableView()
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addTextFieldRules(){
        self.validationRuleSetUserName?.add(rule: UserName)
        self.validationRuleSetUserName?.add(rule: rangeLengthRule)
        self.validationRuleSetUserName?.add(rule: ValidationRuleRequired<String>(failureError: ValidationError(message: "😫")))
        userNameTextField.validationRuleSet = validationRuleSetUserName
        userNameTextField.validateOnInputChange(validationEnabled: true)
    }
    
    
}

extension ViewController: TextFieldEffectsDelegate{
    func validTextField(valid: Bool) {
        connectButton.isEnabled = valid
    }
}

