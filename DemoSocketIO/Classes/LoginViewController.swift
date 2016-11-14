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
    

    var lastControllerRotationStatus: Bool?
    
    
    
    var validationRuleSetUserName: ValidationRuleSet<String>? = ValidationRuleSet<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        userNameTextField.delegate = self
        userNameTextField.tfdelegate = self
        addTextFieldRules()
        connectButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            lastControllerRotationStatus = appDelegate.shouldRotate
            appDelegate.shouldRotate = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addTextFieldRules(){
        self.validationRuleSetUserName?.add(rule: UserName)
        self.validationRuleSetUserName?.add(rule: rangeLengthRule)
        userNameTextField.validationRuleSet = validationRuleSetUserName
        userNameTextField.validateOnInputChange(validationEnabled: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logInSegue" {
            if let destination = segue.destination as? InitalTableViewController {
                destination.nickName = self.userNameTextField.text!
            }
        }
    }
    
    
}

extension ViewController: TextFieldEffectsDelegate{
    func validTextField(valid: Bool) {
        connectButton.isEnabled = valid
    }
}

