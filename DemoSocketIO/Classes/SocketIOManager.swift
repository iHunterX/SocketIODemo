//
//  SocketIOManager.swift
//  DemoSocketIO
//
//  Created by Đinh Xuân Lộc on 10/20/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.0.120:5000")! as URL)
    
    override init() {
        super.init()
       
    }
    
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    func connectToServerWithNickname(nickname: String, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
        
        socket.emit("connectUser", nickname)
        socket.on("userList") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as? [[String: AnyObject]])
        }
        
        listenForOtherMessages()
    }
    
    func findUserWithNickName(nickname:String,completionHandler: @escaping (_ isAvailable:Bool, _ errorString:String?) -> Void){
        socket.emitWithAck("findingUsername", nickname).timingOut(after: 4) { (data) in
            let isErrorString:String?
            guard let arrResp = data as NSArray? else{return}
            if let str = arrResp.firstObject as? String {
                if str == "NO ACK" {
                    ////No response data goes here!!!!
                    isErrorString = "Can't get data from the server... "
                    completionHandler(false,isErrorString)
                } else {
                    ////response data goes here!!!!
                    guard let avail = arrResp.firstObject as? Bool else {return}
                    isErrorString = nil
                    completionHandler(avail,isErrorString)
                }
            }
            else{
                //Cast to bool value
                if let avail = arrResp.firstObject as? Bool{
                    isErrorString = nil
                    completionHandler(avail,isErrorString)
                }
                
            }
        }
    }
    
    func registerWithNickname(nickname:String, completionHandler: @escaping (_ user:User?, _ error:String?)->Void){
        
        socket.emitWithAck("registerWithUserName", nickname).timingOut(after: 4) { (data) in
            guard let regInfo = data[0] as? [String:Any] else {return}
            var userIn:User?
            var isError:String?
            
            if let isErrorParse = regInfo["error"] as? String{
                isError = isErrorParse
            }
            if isError != nil{
                userIn = nil
            }else{
                if let info = regInfo["info"] as? [String:Any] {
                    if let userParse = User(data: info){
                        userIn = userParse
                    }
                }
            }
            print(isError ?? "fsdfsd",userIn ?? "asdfasdf")
            completionHandler(userIn,isError)
        }
        
    }
    
    
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    func sendMessageJSQ(message: JSQMessage) {
        socket.emit("chatMessage", message.senderDisplayName ,message.text)
    }
    func sendMessageJSQ2(message: JSQMessage) {
//        print(message)
//        print()
//        print(dict)
        guard let m = Message(JSQMessage: message) else{
            return
        }
        socket.emit("chatMessage2", m.toJson())
        print(m.toJson())
        
        //        print(a["text"])
        //        socket.emit("chatMessage2", message)
        //        socket.emit("chatMessage2", with: [message])
    }
    
    
    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: Any]) -> Void) {
        socket.on("newChatMessage") {(dataArray, socketAck) -> Void in
            var messageDictionary = [String: Any]()
            messageDictionary["nickname"] = dataArray[0] as! String
            messageDictionary["message"] = dataArray[1] as! String
            messageDictionary["date"] = dataArray[2] as! String
            
            completionHandler(messageDictionary)
        }
    }
    
    
    private func listenForOtherMessages() {
        socket.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasConnectedNotification"), object: dataArray[0] as! [String: AnyObject])
        }
        
        socket.on("userExitUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasDisconnectedNotification"), object: dataArray[0] as! String)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "usersTypingNotification"), object: dataArray[0] as! [String:Any] )
        }
    }
    
    
    func sendStartTypingMessage(nickname: String) {
        socket.emit("startType", nickname)
    }
    
    
    func sendStopTypingMessage(nickname: String) {
        socket.emit("stopType", nickname)
    }
}
