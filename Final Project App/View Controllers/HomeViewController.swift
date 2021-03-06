//
//  ViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/1/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var userProfilePicture: UIImageView!
    
    @IBOutlet weak var rosterButton: UIButton!
    @IBOutlet weak var announcementsButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var resourcesButton: UIButton!
    //@IBOutlet weak var guruButton: UIButton!
    @IBOutlet weak var execButton: UIButton!
    @IBOutlet weak var messagingButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    
    private let storage = Storage.storage().reference()
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 70))
        navBar.largeContentTitle = "HELLO WORLD"
        navBar.backgroundColor = .systemPurple
       
        view.addSubview(navBar)
        title = "Home"
        
        // Do any additional setup after loading the view.
        rosterButton.layer.cornerRadius = 10
        announcementsButton.layer.cornerRadius = 10
        calendarButton.layer.cornerRadius = 10
        resourcesButton.layer.cornerRadius = 10
        //guruButton.layer.cornerRadius = 10
        execButton.layer.cornerRadius = 10
        messagingButton.layer.cornerRadius = 10
        galleryButton.layer.cornerRadius = 10

        rosterButton.layer.borderWidth = 2.0
        announcementsButton.layer.borderWidth = 2.0
        calendarButton.layer.borderWidth = 2.0
        resourcesButton.layer.borderWidth = 2.0
        //guruButton.layer.borderWidth = 2.0
        execButton.layer.borderWidth = 2.0
        messagingButton.layer.borderWidth = 2.0
        galleryButton.layer.borderWidth = 2.0

        rosterButton.layer.borderColor = UIColor.systemGray5.cgColor
        announcementsButton.layer.borderColor = UIColor.systemGray5.cgColor
        calendarButton.layer.borderColor = UIColor.systemGray5.cgColor
        resourcesButton.layer.borderColor = UIColor.systemGray5.cgColor
        //guruButton.layer.borderColor = UIColor.black.cgColor
        execButton.layer.borderColor = UIColor.systemGray5.cgColor
        messagingButton.layer.borderColor = UIColor.systemGray5.cgColor
        galleryButton.layer.borderColor = UIColor.systemGray5.cgColor
        
        //loadProfilePic()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
        
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = false;
    }
    
    @IBAction func pushToRoster(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RosterViewController") as! RosterViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToAnnoucements(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AnnouncementsViewController") as! AnnouncementsViewController
        nextViewController.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToCalendar(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToResources(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResourcesViewController") as! ResourcesViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    @IBAction func pushToExec(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ExecViewController") as! ExecViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToMessaging(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToGallery(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

