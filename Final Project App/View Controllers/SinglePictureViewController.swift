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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let imageFrame = CGRect(x: view.frame.midX - 175, y: 200, width: 350, height: 350)
        
        let imageView2 = UIImageView(frame: imageFrame)
        imageView2.contentMode = .scaleAspectFit
        imageView2.image = theImage
        view.addSubview(imageView2)
    }
    

  

}
