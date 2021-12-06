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
    var photoCount = 0
    
    //storage reference
    private let storage = Storage.storage().reference()

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        fetchData()
            
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.photoCount = self.theData.count
        }
       
    }
    
    func setUpNav(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "Back")

        navBar.setItems([navItem], animated: false)
    }
    
    func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
       
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let test = SinglePictureViewController()
        test.theImage = theData[indexPath.item]

        self.present(test, animated: true, completion: nil)
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
        photoCount += 1
        let photoPath = "galleryImages/image" + String(photoCount)
        
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
                        self.theData.append(image ?? UIImage(named: "noImage")!)
                        self.collectionView.reloadData()
                    }
                   
                })
                task.resume()
                
                
            })
            
        })

        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchData(){
       
        let photoPath = "galleryImages"
        
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
                                self.collectionView.reloadData()
                            }
                           
                        })
                        task.resume()
                    })
                }
            })
            
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
    
    
}
