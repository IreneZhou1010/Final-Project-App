//
//  IndividualExecViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 12/5/21.
//

import UIKit

class IndividualExecViewController: UIViewController {

    var person:String!
    var position:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
        let image = UIImageView(frame: CGRect(x: 20, y: 88, width: 350, height: 377))
        image.autoresizesSubviews = false
        image.image = UIImage.init(named: person)
        image.backgroundColor = UIColor.gray
        
        
        let name = UITextField(frame: CGRect(x: 89, y: 465, width: 212, height: 34))
        name.text = person
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let pos = UITextField(frame: CGRect(x: 60, y: 507, width: 270, height: 36))
        pos.text = position
        pos.textAlignment = .center
        
        
        
        view.addSubview(name)
        view.addSubview(image)
        view.addSubview(pos)
    }


}
