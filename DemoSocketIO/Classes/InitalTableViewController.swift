//
//  InitalTableViewController.swift
//  DemoSocketIO
//
//  Created by Đinh Xuân Lộc on 10/21/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class InitalTableViewController: UITableViewController {
    
    //MARK: - View lifecycle
    let springAnimation = SpringAnimation()
    let socketSingleton = SocketIOManager.sharedInstance
    var userInfo:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            return 10
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "#general"
                break
            default:
                cell.textLabel?.text = "#channel \(indexPath.row)"
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Settings"
                break
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Choose your channel"
        case 1:
            return "Options"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Copyright © 2016 - Đinh Xuân Lộc"
        case 1:
            return "Thanks"
        default:
            return nil
        }
    }
    
    //Mark: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var titleVC = ""
        if let cell = tableView.cellForRow(at: indexPath){
            titleVC = (cell.textLabel?.text)!
        }
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let chatView = chatViewController()
                chatView.title = titleVC
                chatView.userInfo = self.userInfo
                if let thisView  = self.view{
                    if let thisNavController = self.navigationController{
                        thisView.transitionType(navigationController: thisNavController, pushTo: chatView, transType: .push, animationType: kCATruncationStart,animationSubType: nil , duration: 0.5, animated: false)
                    }
                }

                return
//                    self.navigationController?.pushViewController(chatView, animated: true)
            default:
                let chatView = chatViewController()
                chatView.userInfo = self.userInfo
                chatView.title = titleVC
                if let thisView  = self.view{
                    if let thisNavController = self.navigationController{
                        thisView.transitionType(navigationController: thisNavController, pushTo: chatView, transType: .push, animationType: kCATransitionFade,animationSubType: nil, duration: 0.5, animated: false)
                    }
                }
                return
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.present(UINavigationController(rootViewController: SettingsTableViewController()), animated: true, completion: nil)
            default:
                return
            }
        default:
            return
        }
    }
}
