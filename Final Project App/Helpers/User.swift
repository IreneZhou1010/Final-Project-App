//
//  User.swift
//  Final Project App
//
//  Created by Lauren Sands on 11/23/21.
//

import Foundation

class User: Codable {

    // MARK: - Properties

    let uid: String
    let username: String

    // MARK: - Init

    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
}
