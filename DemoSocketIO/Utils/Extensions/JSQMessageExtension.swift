//
//  JSQMessageExtension.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/24/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import Foundation


extension JSQMessage {
    func toJSON() -> Dictionary<String, Any> {
        return ["content": [
            "senderId": self.senderId,
            "senderDisplayName": self.senderDisplayName,
            "sendDate": self.date.timeIntervalSince1970,
            "isMediaMessage": self.isMediaMessage,
            "text": self.text
            ]
        ]
    }
}






