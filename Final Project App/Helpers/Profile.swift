//
//  Profile.swift
//  Final Project App
//
//  Created by Gabi Fowler on 12/3/21.
//

import Foundation
import Firebase



class Profile {
    
    private var db = Firestore.firestore()
    var firstname = "User"
    var lastname = "Name"
    var pfp = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
    var user = Auth.auth().currentUser

    func printUser(){
        print(user?.uid)
        print(user?.displayName)
    }
    
    
    
    
}

