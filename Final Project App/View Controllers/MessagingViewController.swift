//
//  MessagingViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit
import Firebase

class MessagingViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var usersName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //profilePic.layer.cornerRadius = 100
        
        print("Photo url is ", Auth.auth().currentUser?.photoURL)
        let url = (Auth.auth().currentUser?.photoURL)!
        
        if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            profilePic.image = image
                        }
                    }
        
        usersName.text = Auth.auth().currentUser?.displayName

        // Do any additional setup after loading the view.
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
