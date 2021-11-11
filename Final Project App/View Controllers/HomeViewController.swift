//
//  ViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/1/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var rosterButton: UIButton!
    @IBOutlet weak var announcementsButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var resourcesButton: UIButton!
    @IBOutlet weak var guruButton: UIButton!
    @IBOutlet weak var execButton: UIButton!
    @IBOutlet weak var messagingButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rosterButton.layer.cornerRadius = 10
        announcementsButton.layer.cornerRadius = 10
        calendarButton.layer.cornerRadius = 10
        resourcesButton.layer.cornerRadius = 10
        guruButton.layer.cornerRadius = 10
        execButton.layer.cornerRadius = 10
        messagingButton.layer.cornerRadius = 10
        galleryButton.layer.cornerRadius = 10

        rosterButton.layer.borderWidth = 2.0
        announcementsButton.layer.borderWidth = 2.0
        calendarButton.layer.borderWidth = 2.0
        resourcesButton.layer.borderWidth = 2.0
        guruButton.layer.borderWidth = 2.0
        execButton.layer.borderWidth = 2.0
        messagingButton.layer.borderWidth = 2.0
        galleryButton.layer.borderWidth = 2.0

        rosterButton.layer.borderColor = UIColor.black.cgColor
        announcementsButton.layer.borderColor = UIColor.black.cgColor
        calendarButton.layer.borderColor = UIColor.black.cgColor
        resourcesButton.layer.borderColor = UIColor.black.cgColor
        guruButton.layer.borderColor = UIColor.black.cgColor
        execButton.layer.borderColor = UIColor.black.cgColor
        messagingButton.layer.borderColor = UIColor.black.cgColor
        galleryButton.layer.borderColor = UIColor.black.cgColor
    }

    
    
}

