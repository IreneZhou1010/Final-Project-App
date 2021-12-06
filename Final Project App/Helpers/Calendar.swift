//
//  Calendar.swift
//  Final Project App
//
//  Created by user203874 on 12/5/21.
//

import Foundation
import Firebase
import UIKit

class Calendar {
    
    private var db = Firestore.firestore()
    var Dates:[String] = []
    var Events:[String] = []

   
//    func addToIH(name:String){
//        let docRefIH = db.collection("roster").document("IH")
//        docRefIH.setData(["Players" : self.IH])
//    }
//
//    func addToLoca(name:String){
//        let docRefLoca = db.collection("roster").document("Loca")
//        docRefLoca.setData(["Players" : self.Loca])
//    }
//
//
//
//    func removeFromIH(name:String) {
//        let docRefIH = db.collection("roster").document("IH")
//        docRefIH.setData(["Players" : self.IH])
//    }
//    func removeFromLoca(name:String) {
//        let docRefIH = db.collection("roster").document("Loca")
//        docRefIH.setData(["Players" : self.Loca])
//    }
    
    func fetchDataDates (_ completion: @escaping ([String]) -> Void) {
        print("fetching dates")
        let docRefDates = db.collection("calendar").document("Dates")
        docRefDates.getDocument { (document, error) in
            if let document = document, document.exists {
                print("date document exists")
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                print("Calendar data description ", dataDescription)
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachName = String()
                
                let semaphore = DispatchSemaphore(value: 0)
                print("pure data from fb is , " , pureData)
                
                DispatchQueue.global().async {
                    for items in pureData {
                        if (items == "("){
                            semaphore.signal()
                                                    }
                        
                        else if (items == ","){
                            self.Dates.append(String(eachName))
                            eachName.removeAll()
                            
                            semaphore.signal()
                        }
                        else if (items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachName.append(items)
                            semaphore.signal()
                        }
                    }
                    self.Dates.append(String(eachName))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        // call the completion, but we are doing it only once,
                        // when the function is finished with its work
                        completion(self.Dates)
                    }
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    func fetchDataEvents (_ completion: @escaping ([String]) -> Void) {
        print("fetching events")
        let docRefEvents = db.collection("calendar").document("Events")
        docRefEvents.getDocument { (document, error) in
            if let document = document, document.exists {
                print("event document exists")
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachName = String()
                
                let semaphore = DispatchSemaphore(value: 0)
                
                DispatchQueue.global().async {
                    for items in pureData {
                        if (items == "("){
                            semaphore.signal()
                                                    }
                        
                        else if (items == ","){
                            self.Events.append(String(eachName))
                            eachName.removeAll()
                            semaphore.signal()
                        }
                        else if (items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachName.append(items)
                            semaphore.signal()
                        }
                    }
                    self.Events.append(String(eachName))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        // call the completion, but we are doing it only once,
                        // when the function is finished with its work
                        completion(self.Events)
                    }
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
}





