//
//  NewAnnouncementVC.swift
//  Final Project App
//
//  Created by Gabi Fowler on 12/1/21.
//

import Foundation
import UIKit
import Firebase

class NewAnnouncementVC: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var userContent: UITextView!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passcodeLabel: UILabel!
    private var db = Firestore.firestore()
    @IBOutlet weak var charLimitReminder: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var userTitleInput: UITextField!
    var announcementContent : [String] = []
    var announcementType: [String] = []
    var titlesOfCells: [String] = []
    
    let pickerChoices = ["Important", "Social", "Tournament"]
    
    @IBOutlet weak var userAddAnnouncement: UIButton!
    /*func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("In this fxn")
        // get the current text, or use an empty string if that failed
        let currentText = textView.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        // make sure the result is under 16 characters
        return updatedText.count <= 16
    }*/
    
    
    func textViewDidChange(_ textView: UITextView) {
        let numChars = userContent.text.count
        charCount.text = "\(numChars)/400"
        
        if(numChars >= 400){
            charCount.textColor = .systemRed
        }
        if(numChars <= 400){
            charCount.textColor = .systemGray
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
         
        
        userContent.delegate = self
        
        setUpElements()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
        //try the following code for segue
        //self.performSegue(withIdentifier: "toCreateUsername", sender: self)
    }
    
    //for design, make functions in Utilities Class
    func setUpElements(){
        //addButton.
        //style elements
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerChoices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerChoices[row]
    }
    
    
    @IBAction func userWantsToAdd(_ sender: Any) {
        if(passwordInput.text == "wuwuannounce21"){
            passcodeLabel.textColor = .black
            if(userTitleInput.text != ""){
                titleText.textColor = .black
                print("Ok they actually inputted something")
                if((userContent.text.count > 0) && (userContent.text.count <= 450)){
                    userContent.textColor = .black
                    
                    print("Ok correct length")
                    
                    allowAnnouncement()
                }
                else{
                    charLimitReminder.textColor = .systemRed
                }
            }
            
            else{
                titleText.textColor = .systemRed
            }
            
            
        }
        else{
            passcodeLabel.textColor = .systemRed
            passcodeLabel.text = "Enter the correct password in order to make an announcement."
        }
    }
    
    func allowAnnouncement(){
        let contentToAdd = userContent.text
        let titleToAdd = userTitleInput.text
        
        //getting the type
        print("Think this might be the problem , ", picker.selectedRow(inComponent: 0))
        let typeToAdd = pickerChoices[picker.selectedRow(inComponent: 0)]
        
        print("Plan to add ", titleToAdd, contentToAdd, typeToAdd)
      
        let docRefContent = db.collection("announcements").document("AnnouncementContent")
        fetchDataAnnouncementContent{ result in
            self.announcementContent = result
            self.announcementContent.append(contentToAdd ?? "empty announcement") //expect that I know that won't happen
            docRefContent.setData(["AnnouncementContent" : self.announcementContent])
        }
        
        
    }
    
    
    func fetchDataAnnouncementContent(_ completion: @escaping ([String]) -> Void){
        let docRefAnnouncementC = db.collection("announcements").document("AnnouncementContent")
        docRefAnnouncementC.getDocument{(document, error) in
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachContent = String()
                
                
                let semaphore = DispatchSemaphore(value: 0)
                print("pure data from fb is , " , pureData)
                
                DispatchQueue.global().async {
                    for items in pureData{
                        if(items == "("){
                            semaphore.signal()
                        }
                        
                        else if(items == ","){
                            self.announcementContent.append(String(eachContent))
                            eachContent.removeAll()
                            semaphore.signal()
                        }
                        else if(items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachContent.append(items)
                            semaphore.signal()
                        }
                        
                        
                    }
                    
                    self.announcementContent.append(String(eachContent))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        completion(self.announcementContent)
                    }
                }
                
                
               
            }
            else{
                print("Sorry bud")
            }
        }
        
        
        
    }
    
    
    
    func fetchDataAnnouncementType(_ completion: @escaping ([String]) -> Void){
        let docRefAnnouncementType = db.collection("announcements").document("AnnouncementType")
        docRefAnnouncementType.getDocument{(document, error) in
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachType = String()
                
                
                let semaphore = DispatchSemaphore(value: 0)
                print("pure data from fb is , " , pureData)
                
                DispatchQueue.global().async {
                    for items in pureData{
                        if(items == "("){
                            semaphore.signal()
                        }
                        
                        else if(items == ","){
                            self.announcementType.append(String(eachType))
                            eachType.removeAll()
                            semaphore.signal()
                        }
                        else if(items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachType.append(items)
                            print("each type now = ", eachType)
                            semaphore.signal()
                        }
                        
                        
                    }
                    self.announcementType.append(String(eachType))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        completion(self.announcementType)
                    }
                }
                
                
               
            }
            else{
                print("Sorry bud")
            }
        }
    }
    
    func fetchDataAnnouncementTitle(_ completion: @escaping ([String]) -> Void){
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
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
