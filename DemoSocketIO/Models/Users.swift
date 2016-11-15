////
////  Users.swift
////  DemoSocketIO
////
////  Created by Loc.dx-KeizuDev on 11/3/16.
////  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
////
//
//import Foundation
//
//enum User: String {
//    case Leonard    = "053496-4509-288"
//    case Squires    = "053496-4509-289"
//    case Jobs       = "707-8956784-57"
//    case Cook       = "468-768355-23123"
//    case Wozniak    = "309-41802-93823"
//}
//
//// Helper Function to get usernames for a secific User.
//func getName(_ user: User) -> String{
//    switch user {
//    case .Squires:
//        return "Jesse Squires"
//    case .Cook:
//        return "Tim Cook"
//    case .Wozniak:
//        return "Steve Wozniak"
//    case .Leonard:
//        return "Dan Leonard"
//    case .Jobs:
//        return "Steve Jobs"
//    }
//}
////// Create Names to display
////let DisplayNameSquires = "Jesse Squires"
////let DisplayNameLeonard = "Dan Leonard"
////let DisplayNameCook = "Tim Cook"
////let DisplayNameJobs = "Steve Jobs"
////let DisplayNameWoz = "Steve Wazniak"
//
//
//
//// Create Unique IDs for avatars
//let AvatarIDLeonard = "053496-4509-288"
//let AvatarIDSquires = "053496-4509-289"
//let AvatarIdCook = "468-768355-23123"
//let AvatarIdJobs = "707-8956784-57"
//let AvatarIdWoz = "309-41802-93823"
//
//let AvatarLeonard = JSQMessagesAvatarImageFactory().avatarImage(withUserInitials: "DL", backgroundColor: UIColor.jsq_messageBubbleLightGray(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12))
//
//let AvatarCook = JSQMessagesAvatarImageFactory().avatarImage(withUserInitials: "TC", backgroundColor: UIColor.gray, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12))
//
//// Create avatar with Placeholder Image
//let AvatarJobs = JSQMessagesAvatarImageFactory().avatarImage(withPlaceholder: UIImage(named:"demo_avatar_jobs")!)
//
//let AvatarWoz = JSQMessagesAvatarImageFactory().avatarImage(withUserInitials: "SW", backgroundColor: UIColor.jsq_messageBubbleGreen(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12))
//
//let AvatarSquires = JSQMessagesAvatarImageFactory().avatarImage(withUserInitials: "JSQ", backgroundColor: UIColor.gray, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12))
//
//// Helper Method for getting an avatar for a specific User.
//func getAvatar(_ id: String) -> JSQMessagesAvatarImage{
//    
//    if let user = User(rawValue: id) {
//        switch user {
//        case .Leonard:
//            return AvatarLeonard
//        case .Squires:
//            return AvatarSquires
//        case .Cook:
//            return AvatarCook
//        case .Wozniak:
//            return AvatarWoz
//        case .Jobs:
//            return AvatarJobs
//        }
//    }
//    else {
//        return AvatarLeonard
//    }
//}
//
//
//
