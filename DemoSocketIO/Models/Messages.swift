//
//  Messages.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/15/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

struct Message {
    var senderID:String
    var senderNickname:String
    var sendDate:TimeInterval
    var isMediaMessage:Bool
    var text:String?
    var media: JSQMessageMediaData?
    
    init?(JSQMessage:JSQMessage) {
        self.senderID = JSQMessage.senderId
        self.senderNickname = JSQMessage.senderDisplayName
        self.sendDate = JSQMessage.date.timeIntervalSince1970
        self.isMediaMessage = JSQMessage.isMediaMessage
        self.text = JSQMessage.text
        if isMediaMessage {
            guard let media = JSQMessage.media else {
                return nil
            }
            self.media = media
        }
    }
    func toJson() -> String {
        let json = JSONSerializer.toJson(self)
        return json
    }
}
