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
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        title = "Home"
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

    
    @IBAction func pushToRoster(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RosterViewController") as! RosterViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToAnnoucements(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AnnouncementsViewController") as! AnnouncementsViewController
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
    @IBAction func pushToGuru(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GuruViewController") as! GuruViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToExec(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ExecViewController") as! ExecViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToMessaging(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MessagingViewController") as! MessagingViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func pushToGallery(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

