//
//  RequiredViewController.swift
//  DemoSocketIO
//
//  Created by Đinh Xuân Lộc on 10/28/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

class RequiredViewController: PAPermissionsViewController,PAPermissionsViewControllerDelegate {

    let cameraCheck = PACameraPermissionsCheck()
    let locationCheck = PALocationPermissionsCheck()
    let microphoneCheck = PAMicrophonePermissionsCheck()
    let photoLibraryCheck = PAPhotoLibraryPermissionsCheck()
    lazy var notificationsCheck : PAPermissionsCheck = {
        if #available(iOS 10.0, *) {
            return PAUNNotificationPermissionsCheck()
        } else {
            return PANotificationsPermissionsCheck()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.delegate = self
        let permissions = [
            PAPermissionsItem.itemForType(.location, reason: PAPermissionDefaultReason)!,
            PAPermissionsItem.itemForType(.microphone, reason: PAPermissionDefaultReason)!,
            PAPermissionsItem.itemForType(.photoLibrary, reason: PAPermissionDefaultReason)!,
            PAPermissionsItem.itemForType(.notifications, reason: "Required to send you great updates")!,
            PAPermissionsItem.itemForType(.camera, reason: PAPermissionDefaultReason)!]

        
        let handlers = [

            PAPermissionsType.location.rawValue: self.locationCheck,
            PAPermissionsType.microphone.rawValue :self.microphoneCheck,
            PAPermissionsType.photoLibrary.rawValue: self.photoLibraryCheck,
            PAPermissionsType.camera.rawValue: self.cameraCheck,
            PAPermissionsType.notifications.rawValue: self.notificationsCheck
        ]

        
        self.setupData(permissions, handlers: handlers)

        // Do any additional setup after loading the view.
        self.tintColor = UIColor.white
        self.backgroundImage = #imageLiteral(resourceName: "background")
        self.useBlurBackground = false
        self.titleText = "iSpam"
        self.detailsText = "Please enable the following"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func permissionsViewControllerDidContinue(_ viewController: PAPermissionsViewController) {
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "MainController") as? UINavigationController {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let presentingViewController: UIViewController! = self.presentingViewController
//            
//            self.dismiss(animated: false) {
//                // go back to MainMenuView as the eyes of the user
//                presentingViewController.dismiss(animated: false, completion: {
////                    self.present(loginVC, animated: true, completion: nil)
//                })
//            }
            
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: true, completion: nil)
        }
        
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
