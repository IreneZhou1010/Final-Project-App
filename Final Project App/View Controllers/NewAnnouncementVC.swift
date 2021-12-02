//
//  NewAnnouncementVC.swift
//  Final Project App
//
//  Created by Gabi Fowler on 12/1/21.
//

import Foundation
import UIKit

class NewAnnouncementVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var userContent: UITextView!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passcodeLabel: UILabel!
    
    
    
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
        
        
        //try the following code for segue
        //self.performSegue(withIdentifier: "toCreateUsername", sender: self)
    }
    
    //for design, make functions in Utilities Class
    func setUpElements(){
        //addButton.
        //style elements
    }
    
    
    @IBAction func userWantsToAdd(_ sender: Any) {
        if(passwordInput.text == "wuwuannounce21"){
            print("Correct password!")
            
            allowAnnouncement()
        }
        else{
            passcodeLabel.textColor = .systemRed
            passcodeLabel.text = "Enter the correct password in order to make an announcement."
        }
    }
    
    func allowAnnouncement(){
        let defaults = UserDefaults.standard
        var fromDAC = defaults.array(forKey: "AnnouncementContent")
        fromDAC?.append(userContent.text ?? "")
        print(fromDAC)
        var fromDAT = defaults.array(forKey: "AnnouncementType")
        fromDAT?.append("Important")
        var fromDCT = defaults.array(forKey: "TitlesOfCells")
        fromDCT?.append("Gob hardcodes")
        
        defaults.set(fromDAC, forKey: "AnnouncementContent")
        defaults.set(fromDAT, forKey: "AnnouncementType")
        defaults.set(fromDCT, forKey: "TitlesOfCells")
        
        print(defaults.array(forKey: "AnnouncementContent"))
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
