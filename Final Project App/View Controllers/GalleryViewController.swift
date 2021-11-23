//
//  GalleryViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit
import Photos
import FirebaseStorage
import Firebase

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    

    var imagePicker = UIImagePickerController()
    var imageTaken: UIImage!
    var theData: [String] = [] //note sure what it should be an array of
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        
    }
    
    func setUpNav(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "Back")
        //let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(selectorName:))
        //navItem.rightBarButtonItem = doneItem

        navBar.setItems([navItem], animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        //set image
        
        return cell
    }
    
    
    @IBAction func addPhoto(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func fetchData(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
    }
    
    
    func checkPermissions(){
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized{
            PHPhotoLibrary.requestAuthorization({   (status: PHAuthorizationStatus) -> Void in()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
        }else{
            PHPhotoLibrary.requestAuthorization(requestAuthHandler)
        }
    }
    
    func requestAuthHandler(status: PHAuthorizationStatus){
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            print("We have access ot the photos.")
        }else{
            print("We do not have access to photos.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            print(url)
            uploadToCloud(fileUrl: url)
        }
//        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        self.imageTaken = image
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func uploadToCloud(fileUrl: URL){
        let storage = Storage.storage()
        
        let data = Data()
        
        let storageRef = storage.reference()
        
        let localeFile = fileUrl
        
        let photoRef = storageRef.child("UploadPhotoOne")
        
        let uploadTask = photoRef.putFile(from: localeFile, metadata: nil) {(metadata, err) in
            guard let metadata = metadata else {
                print(err?.localizedDescription ?? "Error occured")
            return
            }
            print("Photo Uploaded")
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

//extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        self.imageTaken = image
//        self.dismiss(animated: true, completion: nil)
//
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}
