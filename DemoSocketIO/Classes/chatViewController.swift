//
//  chatViewController.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 10/31/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

class chatViewController: JSQMessagesViewController,UIGestureRecognizerDelegate {
    
    
    let app = UIApplication.shared.delegate as! AppDelegate
    
    
    //Properties
    var messages = [JSQMessage]()
//    var senderID:String = ""
//    var nickName:String = "Anonymous"{
//        didSet{
//            senderID = nickName + String(randomStringWithLength(len: 9))
//        }
//    }
    var userInfo:User!
    let defaults = UserDefaults.standard
    var conversation: Conversation?
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var textTimer: Timer! = nil
    var stillTyping = false
    var stoppedTyping = true {
        didSet{
            if stoppedTyping == true && stillTyping == false{
                SocketIOManager.sharedInstance.sendStopTypingMessage(nickname: userInfo.userName)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        app.keyboardSingleton.enable = false
        // Do any additional setup after loading the view.
        
        //Important
        ////////////////////////////////////////////////////////////////////////
        addTapGestures()
        SocketIOManager.sharedInstance.connectToServerWithNickname(nickname: userInfo.userName) { (userList) in
        }
        if defaults.bool(forKey: Setting.removeBubbleTails.rawValue) {
            // Make taillessBubbles
            incomingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero, layoutDirection: UIApplication.shared.userInterfaceLayoutDirection).incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
            outgoingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero, layoutDirection: UIApplication.shared.userInterfaceLayoutDirection).outgoingMessagesBubbleImage(with: UIColor.lightGray)
        }
        else {
            // Bubbles with tails
            incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
            outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.lightGray)
        }
        
        
        if defaults.bool(forKey: Setting.removeAvatar.rawValue) {
            collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
            collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        } else {
            collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height:kJSQMessagesCollectionViewAvatarSizeDefault )
            collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height:kJSQMessagesCollectionViewAvatarSizeDefault )
        }
        
        // self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.jsq_defaultTypingIndicator(), style: .plain, target: self, action: #selector(receiveMessagePressed))
        
        // This is a beta feature that mostly works but to make things more stable it is diabled.
        collectionView?.collectionViewLayout.springinessEnabled = false
        
        automaticallyScrollsToMostRecentMessage = true
        
        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleUserTypingNotificationGroup), name: NSNotification.Name(rawValue: "usersTypingNotification"), object: nil)
    }
    func handleUserTypingNotificationGroup(notification: NSNotification) {
        if let typingData = notification.object as? [String:AnyObject]{
            var names = ""
            print(typingData)
            guard let isTyping = typingData["isTyping"] as? Bool else {return}
            guard let nickName = typingData["nickName"] as? String else {return}
            
//            if nickName != self.senderDisplayName() {
//                switch isTyping {
//                case true:
//                    self.showTypingIndicator = true
//                default:
//                    self.showTypingIndicator = false
//                }
//                
//            }
            //var totalTypingUsers = 0
            // for (typingUser, _) in typingUsersDictionary {
            //  if typingUser != nickname {
            //      names = (names == "") ? typingUser : "\(names), \(typingUser)"
            //      totalTypingUsers += 1
            //  }
            //}1
            
            //  if totalTypingUsers > 0 {
            //  let verb = (totalTypingUsers == 1) ? "is" : "are"
            //
            //lblOtherUserActivityStatus.text = "\(names) \(verb) now typing a message..."
            // lblOtherUserActivityStatus.hidden = false
            // }
            // else {
            //lblOtherUserActivityStatus.hidden = true
            // }
            //  if typingUsersDictionary == true{
            //      self.showTypingIndicator = true
            //  }
            //   else{
            //     self.showTypingIndicator = false
//            switch typingData[""] {
//            case true:
//                if
//                self.showTypingIndicator = true
//            default:
//                self.showTypingIndicator = false
//            }
        }
        
    }
    override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == self.inputToolbar.contentView?.textView{
            print("Start typing")
            textTimer?.invalidate()
            textTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.textFieldStopEditing(sender:)), userInfo: nil, repeats: false)
            if stillTyping != true{
                SocketIOManager.sharedInstance.sendStartTypingMessage(nickname: userInfo.userName)
                stillTyping = true
                stoppedTyping = false
            }
        }
        return true
    }
    
    func textFieldStopEditing(sender: Timer) {
        SocketIOManager.sharedInstance.sendStopTypingMessage(nickname: userInfo.userName)
        print("Stop typing")
        stoppedTyping = true
        stillTyping = false
        
    }
    
    func gestureRecognizer(_: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
    
    func addTapGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAndHideKeyboard(gesture:)))
        gesture.delegate = self
        self.collectionView?.addGestureRecognizer(gesture)
    }
    
    func tapAndHideKeyboard(gesture: UITapGestureRecognizer) {
        if(gesture.state == UIGestureRecognizerState.ended) {
            if(self.inputToolbar.contentView?.textView?.isFirstResponder)! {
                self.inputToolbar.contentView?.textView?.resignFirstResponder()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    
    // MARK: JSQMessagesViewController method overrides
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        /**
         *  Sending a message. Your implementation of this method should do *at least* the following:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishSendingMessage`
         */
//        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
//        SocketIOManager.sharedInstance.sendMessageJSQ(message: message)
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        
        SocketIOManager.sharedInstance.sendMessageJSQ2(message: message)
        self.messages.append(message)
        self.finishSendingMessage(animated: true)
    }
    
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        
        self.inputToolbar.contentView!.textView!.resignFirstResponder()
        
        let sheet = UIAlertController(title: "Media messages", message: nil, preferredStyle: .actionSheet)
        
        let photoAction = UIAlertAction(title: "Send photo", style: .default) { (action) in
            /**
             *  Create fake photo
             */
            let photoItem = JSQPhotoMediaItem(image: UIImage(named: "goldengate"))
            self.addMedia(photoItem)
        }
        
        let locationAction = UIAlertAction(title: "Send location", style: .default) { (action) in
            /**
             *  Add fake location
             */
            let locationItem = self.buildLocationItem()
            
            self.addMedia(locationItem)
        }
        
        let videoAction = UIAlertAction(title: "Send video", style: .default) { (action) in
            /**
             *  Add fake video
             */
            let videoItem = self.buildVideoItem()
            
            self.addMedia(videoItem)
        }
        
        let audioAction = UIAlertAction(title: "Send audio", style: .default) { (action) in
            /**
             *  Add fake audio
             */
            let audioItem = self.buildAudioItem()
            
            self.addMedia(audioItem)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sheet.addAction(photoAction)
        sheet.addAction(locationAction)
        sheet.addAction(videoAction)
        sheet.addAction(audioAction)
        sheet.addAction(cancelAction)
        
        //sheet.popoverPresentationController?.sourceView = self.view
        //sheet.popoverPresentationController?.sourceRect = CGRect(x:self.view.bounds.width / 2.0,y: self.view.bounds.height / 2.0,width: 1.0,height: 1.0)
        //for ipad
        if let presenter = sheet.popoverPresentationController {
            presenter.sourceView = sender
            presenter.sourceRect = sender.bounds
        }
        
        self.present(sheet, animated: true, completion: nil)
    }
    
    func buildVideoItem() -> JSQVideoMediaItem {
        let videoURL = URL(fileURLWithPath: "file://")
        
        let videoItem = JSQVideoMediaItem(fileURL: videoURL, isReadyToPlay: true)
        
        return videoItem
    }
    
    func buildAudioItem() -> JSQAudioMediaItem {
        let sample = Bundle.main.path(forResource: "jsq_messages_sample", ofType: "m4a")
        let audioData = try? Data(contentsOf: URL(fileURLWithPath: sample!))
        
        let audioItem = JSQAudioMediaItem(data: audioData)
        
        return audioItem
    }
    
    func buildLocationItem() -> JSQLocationMediaItem {
        let ferryBuildingInSF = CLLocation(latitude: 37.795313, longitude: -122.393757)
        
        let locationItem = JSQLocationMediaItem()
        locationItem.setLocation(ferryBuildingInSF) {
            self.collectionView!.reloadData()
        }
        
        return locationItem
    }
    
    func addMedia(_ media:JSQMediaItem) {
        let message = JSQMessage(senderId: self.senderId(), displayName: self.senderDisplayName(), media: media)
        self.messages.append(message)
        
        //Optional: play sent sound
        
        self.finishSendingMessage(animated: true)
    }
    
    
    //MARK: JSQMessages CollectionView DataSource
    
    override func senderId() -> String {
        return userInfo.userID
    }
    
    override func senderDisplayName() -> String {
        return userInfo.userName
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        
        return messages[indexPath.item].senderId == self.senderId() ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        let message = messages[indexPath.item]
//        return getAvatar(message.senderId)
        return JSQMessagesAvatarImageFactory().avatarImage(withUserInitials: "DL", backgroundColor: UIColor.jsq_messageBubbleLightGray(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12))
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        /**
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         *  The other label text delegate methods should follow a similar pattern.
         *
         *  Show a timestamp for every 3rd message
         */
        if (indexPath.item % 20 == 0) {
            let message = self.messages[indexPath.item]
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        let message = messages[indexPath.item]
        
        // Displaying names above messages
        //Mark: Removing Sender Display Name
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         */
        if defaults.bool(forKey: Setting.removeSenderDisplayName.rawValue) {
            return nil
        }
        
        if message.senderId == self.senderId() {
            return nil
        }
        
        return NSAttributedString(string: message.senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForCellTopLabelAt indexPath: IndexPath) -> CGFloat {
        /**
         *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
         */
        
        /**
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         *  The other label height delegate methods should follow similarly
         *
         *  Show a timestamp for every 3rd message
         */
        if indexPath.item % 20 == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        return 0.0
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         */
        if defaults.bool(forKey: Setting.removeSenderDisplayName.rawValue) {
            return 0.0
        }
        
        /**
         *  iOS7-style sender name labels
         */
        let currentMessage = self.messages[indexPath.item]
        
        if currentMessage.senderId == self.senderId() {
            return 0.0
        }
        
        if indexPath.item - 1 > 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == currentMessage.senderId {
                return 0.0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
}

