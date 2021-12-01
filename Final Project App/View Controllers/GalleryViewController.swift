//
//  GalleryViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
// code credit: https://www.youtube.com/watch?v=TAF6cPZxmmI
//NOTE TO LAUREN 12/1 --> figure out cell sizing, figure out url download thing for when you upload a photo
import UIKit
import Photos
import FirebaseStorage
import Firebase

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    var imagePicker = UIImagePickerController()
    var imageTaken: UIImage!
    var theData: [UIImage] = [] //note sure what it should be an array of
    
    //storage reference
    private let storage = Storage.storage().reference()
    let userDefault = UserDefaults.standard
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        let imageURLS = (self.userDefault.object(forKey: "imageURLS") as? [String]) ?? []
        print("number of urls: \(imageURLS.count)")
        print("about to fetch")
        fetchData()
            
        
        DispatchQueue.main.async {
            print("about to reload")
            self.collectionView.reloadData()
        }
       
    }
    
    func setUpNav(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "Back")
        //let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(selectorName:))
        //navItem.rightBarButtonItem = doneItem

        navBar.setItems([navItem], animated: false)
    }
    
    func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
       
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCollectionViewCell
        
        //set image
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.image = theData[indexPath.item]
        
        return cell
    }
    
    
    @IBAction func addPhoto(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true //crop image to square
        self.present(imagePicker, animated: true, completion: nil)
        
        //if user selects image, go to func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        
        //if user cancels, go to func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        guard let imageData = image.pngData() else{
            return
        }
        
        //do user defaults here
        
        
        
        var pathArray = (userDefault.object(forKey: "pathArray") as? [String]) ?? []
        let photoPath = "galleryImages/image" + String(pathArray.count + 1)
        pathArray.append(photoPath)
        
        userDefault.setValue(pathArray, forKey: "pathArray")
        
        //upload image data
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
                
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                
                var imageURLS = (self.userDefault.object(forKey: "imageURLS") as? [String]) ?? []
                imageURLS.append(urlString)
                self.userDefault.setValue(imageURLS, forKey: "imageURLS")
                self.collectionView.reloadData()
                
            })
            
        })
        
//      upload image data
        //get download url
        //save download url to user defaults
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchData(){
        print("about to start fetching")
        guard let imageURLS = userDefault.object(forKey: "imageURLS") as? [String] else{
                print("Error retrieving imageURLs from userDefaults")
                return
                }
        print("here 1")
        for urlString in imageURLS{
            guard let url = URL(string: urlString) else{
                print("oops thats bad")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url, completionHandler:  { data, _, error in
                guard let data = data, error == nil else{
                    print("oops there is an error")
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.theData.append(image ?? UIImage(named: "noImage")!)
                    print("fetching")
                    print("data count: \(self.theData.count)")
                    print("reload in here")
                    self.collectionView.reloadData()
                }
                //there is an image in assets called "noImage"
            })
            task.resume()
            print("here 5")
        }
      
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
            print("We have access to the photos.")
        }else{
            print("We do not have access to photos.")
        }
    }
    
    
    
    func uploadToCloud(fileUrl: URL){
        
        
        let data = Data()
        
        
        
        let localeFile = fileUrl
        let urlString = localeFile.absoluteString
        var imageURLS = (userDefault.object(forKey: "imageURLS") as? [String]) ?? []
        imageURLS.append(urlString)
        userDefault.setValue(imageURLS, forKey: "imageURLS")
        
        
        var pathArray = (userDefault.object(forKey: "pathArray") as? [String]) ?? []
        let photoPath = "galleryImages/image" + String(pathArray.count + 1)
        pathArray.append(photoPath)
        userDefault.setValue(pathArray, forKey: "pathArray")
        
        let photoRef = storage.child(photoPath)
        
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
