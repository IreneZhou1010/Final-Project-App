//
//  Profile.swift
//  Final Project App
//
//  Created by Gabi Fowler on 12/3/21.
//

import Foundation
import Firebase
//import { getAuth } from "firebase/auth";



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
    
    
    
    /*func fetchDataProfile(_ completion: @escaping ([String]) -> Void){
        let docRefAnnouncementT = db.collection("announcements").document("AnnouncementTitle")
        docRefAnnouncementT.getDocument{(document, error) in
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachTitle = String()
                
                
                let semaphore = DispatchSemaphore(value: 0)
                print("pure data from fb is , " , pureData)
                
                DispatchQueue.global().async {
                    for items in pureData{
                        if(items == "("){
                            semaphore.signal()
                        }
                        
                        else if(items == ","){
                            self.titlesOfCells.append(String(eachTitle))
                            eachTitle.removeAll()
                            semaphore.signal()
                        }
                        else if(items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachTitle.append(items)
                            semaphore.signal()
                        }
                        
                        
                    }
                    
                    self.titlesOfCells.append(String(eachTitle))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        completion(self.titlesOfCells)
                    }
                }
                
                
               
            }
            else{
                print("Sorry bud")
            }
        }
    }*/
}

