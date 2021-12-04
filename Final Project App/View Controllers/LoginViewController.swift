//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by Lauren Sands on 11/8/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    //for design, make functions in Utilities Class
    func setUpElements(){
        
        //hide error label
        errorLabel.alpha = 0
        
        
    }
    
    func validateFields() -> String?{
        //check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        //validate text fields
        let error = validateFields()
        
        if error != nil{
            //There is something wrong with the fields, show error message
            showError(error!)
        }
        else{
            //clean up data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //log in user
            Auth.auth().signIn(withEmail: email, password: password) { (result_, err) in
                if err != nil{
                    //couldn't sign in
                    self.errorLabel.text = err?.localizedDescription
                    self.errorLabel.alpha = 1
                }else{
                    if let providerData = Auth.auth().currentUser?.providerData{
                           for item in providerData {
                               print("item is" , "\(item.providerID)")
                           }
                       }
                    self.transitionToHome()
                }
            }
            
        }
        
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
