//
//  MessagingViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit
import Firebase

class MessagingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var profilePic: UIImageView!
    
    
    @IBOutlet weak var usersName: UILabel!
    var imagePicker = UIImagePickerController()
    
    var theData: [UIImage] = []
    var photoCount = 0
    
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        
        self.profilePic.frame = CGRect(x: self.view.frame.midX - 75, y: 200, width: 150, height: 150)
        //profilePic.layer.cornerRadius = 100
        
        print("Current photo url is ", Auth.auth().currentUser?.photoURL)
        
        
        
        let url = (Auth.auth().currentUser?.photoURL) ?? URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
        
        let stringversionofurl = url!.absoluteString 
    
        
        self.storage.child(stringversionofurl).downloadURL(completion: { url, error in
            guard let url = url, error == nil else{
                return
            }
            
            let task = URLSession.shared.dataTask(with: url, completionHandler:  { data, _, error in
                guard let data = data, error == nil else{
                    print("Error Occured")
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.profilePic.image = image
                }
               
            })
            task.resume()
            //self.collectionView.reloadData()
            
        })
        
        /*if let data = try? Data(contentsOf: possiblePath) {
                        if let image = UIImage(data: data) {
                            profilePic.image = image
                        }
                    }*/
        
        usersName.text = Auth.auth().currentUser?.displayName

        // Do any additional setup after loading the view.
    }
    
    
   
    @IBAction func changeProfilePic(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true //crop image to square
        self.present(imagePicker, animated: true, completion: nil)
        
        let url = (Auth.auth().currentUser?.photoURL)!
        
        let stringversionofurl = url.absoluteString
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        guard let imageData = image.pngData() else{
            return
        }
        
        photoCount = theData.count
        photoCount = photoCount + 1
            
        let photoPath = "ProfilePictures/image" + String(photoCount)
        let profileChange = Auth.auth().currentUser?.createProfileChangeRequest()
        profileChange?.photoURL = URL(string: photoPath)
        profileChange?.commitChanges()
        
        storage.child(photoPath).putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else{
                print("Failed to Upload")
                return
            }
            //get download url
            self.storage.child(photoPath).downloadURL(completion: { url, error in
                guard let url = url, error == nil else{
                    return
                }
                
                let task = URLSession.shared.dataTask(with: url, completionHandler:  { data, _, error in
                    guard let data = data, error == nil else{
                        print("Error Occured")
                        return
                    }
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.profilePic.image = image
                        self.profilePic.frame = CGRect(x: self.view.frame.midX - 75, y: 200, width: 150, height: 150)
                        
                    }
                   
                })
                task.resume()
                //self.collectionView.reloadData()
                
            })
            
        })

        
        
    }
    
    
    func fetchData(){
       
        let photoPath = "ProfilePictures"
        
            self.storage.child(photoPath).listAll(completion: {list, error in
                if let error = error{
                    return
                }
                for item in list.items{
                    item.downloadURL(completion: { url, error in
                        guard let url = url, error == nil else{
                            return
                        }
                        
                        let task = URLSession.shared.dataTask(with: url, completionHandler:  { data, _, error in
                            guard let data = data, error == nil else{
                                print("Error Occured")
                                return
                            }
                            DispatchQueue.main.async {
                                let image = UIImage(data: data)
                                self.theData.append(image ?? UIImage(named: "noImage")!)
                                
                            }
                           
                        })
                        task.resume()
                    })
                }
            })
            
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

