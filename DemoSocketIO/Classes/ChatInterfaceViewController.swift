//
//  ChatInterfaceViewController.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 10/28/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

class ChatInterfaceViewController:BaseViewController, UITextFieldDelegate{

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTextField: PaddingTextField!
    @IBOutlet weak var buttonView: UIView!
    
    //APPDELEGATE
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        chatTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func sendAction(_ sender: AnyObject) {
        
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
