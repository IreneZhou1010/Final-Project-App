//
//  Utilities.swift
//  Utilities
//
//  Created by Lauren Sands on 11/9/21.
//

import Foundation

class Utilities{
    
    static func isPasswordValid(_ password: String) -> Bool{
        //the crazy looking string is a regular expression https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
