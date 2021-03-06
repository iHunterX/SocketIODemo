//
//  BaseViewController.swift
//  DemoSocketIO
//
//  Created by Đinh Xuân Lộc on 10/21/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    
    
    let UserName = ValidationRulePattern(pattern: .UserName, failureError: ValidationError(message: "Only a-z,A-Z,0-9 and _.- allowed"))
    let digitRule = ValidationRulePattern(pattern: .ContainsNumber, failureError: ValidationError(message: "Must have number"))
    let rangeLengthRule = ValidationRuleLength(min: 5, max: 15, failureError: ValidationError(message: "Must have 5 to 15 characters"))
    let requiredRule = ValidationRuleRequired<String>(failureError: ValidationError(message: "required"))

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel){
            UIAlertAction in
            self.view.isUserInteractionEnabled = true
        }
        // Add the actions
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func isValidEmail(stringValue: String) ->Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: stringValue)
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
