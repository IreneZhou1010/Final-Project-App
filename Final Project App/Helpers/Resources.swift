//
//  Resources.swift
//  Final Project App
//
//  Created by user203874 on 12/5/21.
//

//
//  Roster.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/26/21.
//

import Foundation
import Firebase
import UIKit

class Resources {
    private var db = Firestore.firestore()
    var Social:[String] = []

    
    func addToSocial(name:String){
        let docRefSocial = db.collection("resources").document("Names")
        docRefSocial.setData(["Names" : self.Social])
    }

    func removeFromSocial(name:String) {
        let docRefIH = db.collection("resources").document("Names")
        docRefIH.setData(["Names" : self.Social])
    }
        
        func fetchDataSocial (_ completion: @escaping ([String]) -> Void) {
            let docRefIH = db.collection("resources").document("Names")
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
                                self.Social.append(String(eachName))
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
                        self.Social.append(String(eachName))
                        semaphore.wait()

                        DispatchQueue.main.async {
                            // call the completion, but we are doing it only once,
                            // when the function is finished with its work
                            completion(self.Social)
                        }
                    }

                } else {
                    print("Document does not exist")
                }
            }
        }
}
