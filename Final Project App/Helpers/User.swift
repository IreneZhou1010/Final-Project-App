//
//  User.swift
//  Final Project App
//
//  Created by Lauren Sands on 12/6/21.
//

import Foundation
import UIKit
import FirebaseDatabase

class User: Codable {

    // MARK: - Properties

    let uid: String
    let username: String
    private static var _current: User?

    // MARK: - Init

    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }

    //failable init
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }

        self.uid = snapshot.key
        self.username = username
    }
   
   

    // 2
    static var current: User {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }

        // 4
        return currentUser
    }
   
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // 2
        if writeToUserDefaults {
            // 3
            if let data = try? JSONEncoder().encode(user) {
                // 4
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }

        _current = user
    }
}
