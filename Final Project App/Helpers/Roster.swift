//
//  Roster.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/26/21.
//

import Foundation
import Firebase
import UIKit

class Roster {
    
    private var db = Firestore.firestore()
    var IH:[String] = []
    var Loca:[String] = []

   
    func addToIH(name:String){
        let docRefIH = db.collection("roster").document("IH")
        docRefIH.setData(["Players" : self.IH])
    }
    
    func addToLoca(name:String){
        let docRefLoca = db.collection("roster").document("Loca")
        docRefLoca.setData(["Players" : self.Loca])
    }
    
    func fetchDataIH (_ completion: @escaping ([String]) -> Void) {
        let docRefIH = db.collection("roster").document("IH")
        docRefIH.getDocument { (document, error) in
            if let document = document, document.exists {
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
                            self.IH.append(String(eachName))
                            eachName.removeAll()
                            
                            semaphore.signal()
                        }
                        else if (items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            print("in ih items are ", items)
                            eachName.append(items)
                            semaphore.signal()
                        }
                    }
                    self.IH.append(String(eachName))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        // call the completion, but we are doing it only once,
                        // when the function is finished with its work
                        completion(self.IH)
                    }
                }
                
            } else {
                print("Document does not exist")
                // completion(self.IH)
            }
        }
    }
    
    
    func fetchDataLoca (_ completion: @escaping ([String]) -> Void) {
        let docRefLoca = db.collection("roster").document("Loca")
        docRefLoca.getDocument { (document, error) in
            if let document = document, document.exists {
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
                            self.Loca.append(String(eachName))
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
                    self.Loca.append(String(eachName))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        // call the completion, but we are doing it only once,
                        // when the function is finished with its work
                        completion(self.Loca)
                    }
                }
                
            } else {
                print("Document does not exist")
                // completion(self.IH)
            }
        }
    }
}




