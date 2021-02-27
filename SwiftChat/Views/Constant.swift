//
//  Constant.swift
//  SwiftChat
//
//  Created by Akdag on 27.02.2021.
//

import Foundation
struct A {
    static let appName = "🌷SimpleChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageViewCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"

        static let pink = "BrandPink"
        static let lighPink = "BrandLightPink"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct Alert {
        static let tryAgain = "Try Again"
        static let ok = "OK"
    }
}
