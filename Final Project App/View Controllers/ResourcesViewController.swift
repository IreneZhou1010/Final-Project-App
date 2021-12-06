//
//  ResourcesViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//


import Foundation
import UIKit
import WebKit
import Firebase
//private var db = Firestore.firestore()
var Skills: [String] = []
var Logistics: [String] = []
var Social: [String] = []
var Names: [String] = []
var Links: [String] = []

class ResourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var NameToLink: [String: String] = [:]
    @IBOutlet weak var NewName: UITextField!
    @IBOutlet weak var NewLink: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var resources: [String]?
    var links: [String]?
    var Res = Resources()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        resources = ["Instagram", "Twitter", "Contact Information", "How to Run Hex"]
//        links = ["https://www.instagram.com/wuwultimate/?hl=en", "https://twitter.com/wuwultimate", "https://docs.google.com/spreadsheets/d/1O3_4wPRjNMc3eY8DjbEVdgWoo5ydn4ycROA2YWqZVC4/edit?usp=sharing", "https://ultiworld.com/2021/01/28/hexagon-the-bestagon-a-look-inside-the-hex-offense/"]
        Res.fetchDataNames { result in
            Names = result
            self.Res.Names = Names
            //self.resources = [Social,Logistics]
        }
        Res.fetchDataLinks { result in
            Links = result
            self.Res.Links = Links
        }
        print("Social length \(Names.count)")
//        Res.fetchDataLogistics { result in
//            Logistics = result
//            self.Ros.Logistics = Logistics
//            self.resources = [Social, Logistics]
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let viewContainer = UIView(frame: CGRect(x:0, y:0, width: tableView.frame.width, height: 40))
//        viewContainer.backgroundColor = UIColor.lightGray
//        let labelHeader = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 30))
//
//        labelHeader.textColor = UIColor.white
//        if section == 0{
//            labelHeader.text = "Skills"
//        }
//        if section == 1{
//            labelHeader.text = "Logistics"
//        }
//        if section == 2{
//            labelHeader.text = "Social Media"
//        }
//
//        viewContainer.addSubview(labelHeader)
//        return viewContainer
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = Names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let rvc = ResourceViewer()
        navigationController?.pushViewController(rvc, animated: true)
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prep 1")
        if segue.identifier == "segue" {
            print("prep 1.5")
            if let indexPath = tableView.indexPathForSelectedRow {
                print("prep 2")
                let destination = segue.destination as? ResourceViewer
                destination!.link = Links[indexPath.row]
            }
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
