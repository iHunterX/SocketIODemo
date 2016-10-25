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
//    var validationRuleSetUserName: ValidationRuleSet<String>? = ValidationRuleSet<String>() {
//        didSet { userNameTextField.validationRules = validationRuleSetUserName }
//    }
    var validationRuleSetUserName: ValidationRuleSet<String>? = ValidationRuleSet<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        userNameTextField.delegate = self
        userNameTextFieldRules()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        userNameTextField.validationRuleSet = validationRuleSetUserName
        userNameTextField.validateOnInputChange(validationEnabled: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func userNameTextFieldRules(){
        self.validationRuleSetUserName?.add(rule: UserName)
        self.validationRuleSetUserName?.add(rule: rangeLengthRule)
    }
    
    
}

