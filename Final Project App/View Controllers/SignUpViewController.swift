//
//  SignUpViewController.swift
//  SignUpViewController
//
//  Created by Lauren Sands on 11/8/21.
//

import UIKit
import FirebaseAuth
import Firebase


class SignUpViewController: UIViewController {


    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
    }
    
    //Check the fields and vaildate that the data is correct. If everthing is correct, this method returns nil. Otherwise, it returns an error message
    
    func setUpElements(){
        
        //hide error label
        errorLabel.alpha = 0
        
        //for design, make functions in Utilities Class
    }
    
    func validateFields() -> String?{
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        //Check that password is secure
        //forced unwrapped because would print error message above if it is empty
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Please make sure your password is at least 8 characters, contains a special character, and a number."
        }
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validate fields
        let error = validateFields()
        
        if error != nil{
            //There is something wrong with the fields, show error message
            showError(error!)
        }
        else{
            //create cleaned versions of the data
            //force unwrapping because we validated the fields, so we know there is text in there
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result_, err) in
                if let err = err{
                    //there was an error creating the user
                    self.showError("Error creating user.")
                }else{
                    //user was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    let dataDict = ["firstname" : firstName, "lastname" : lastName, "uid" : result_!.user.uid]
                    
                    db.collection("users").addDocument(data: dataDict) { (error_) in
                        if error_ != nil{
                            //show error message
                            self.showError("Error saving user data.")
                        }else{
                            self.transitionToHome()
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        //change root view controller programmatically
        //"Home" ViewController StoryboardID: HomeVC (this is stored in Helpers -> Constants)
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeVC) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
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
