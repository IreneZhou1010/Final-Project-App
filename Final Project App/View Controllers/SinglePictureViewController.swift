//
//  SinglePictureViewController.swift
//  Final Project App
//
//  Created by Lauren Sands on 12/4/21.
//

import UIKit

class SinglePictureViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    
    var theImage: UIImage = UIImage(named: "noImage")!
        var saveButton = UIButton()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.white
            let imageFrame = CGRect(x: view.frame.midX - 175, y: 200, width: 350, height: 350)
            
            let imageView2 = UIImageView(frame: imageFrame)
            imageView2.contentMode = .scaleAspectFit
            imageView2.image = theImage
            view.addSubview(imageView2)
            
            let buttonFrame = CGRect(x: view.frame.midX - 50, y: 550, width: 100, height: 100)
            saveButton = UIButton(frame: buttonFrame)
            saveButton.setTitle("Save Image", for: .normal)
            saveButton.setTitleColor(UIColor.black, for: .normal)
            saveButton.addTarget(self, action: #selector(self.savePhoto), for: .touchUpInside)
            view.addSubview(saveButton)
        }
        
        @objc func savePhoto(){
            UIImageWriteToSavedPhotosAlbum(theImage, self, nil, nil)
            saveButton.isEnabled = false
            saveButton.setTitle("Saved!", for: .disabled)
        }

    

  

}
