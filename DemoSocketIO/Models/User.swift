//
//  User.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/15/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//1

import Foundation


public struct User {
    var userName:String
    var userID:String
    var created:Bool
    var isConnected:Bool? = false
    
    init?(data:[String:Any]) {
        guard let userName = data["nickname"] as? String else {return nil}
        
        guard let userID = data["id"] as? String else {return nil}
        
        guard let created = data["created"] as? Bool else {return nil}
        
        if let isConnected = data["isConnected"] as? Bool {
            self.isConnected = isConnected
        }
      
        self.created    = created
        self.userName   = userName
        self.userID     = userID
 
    }
    
}
