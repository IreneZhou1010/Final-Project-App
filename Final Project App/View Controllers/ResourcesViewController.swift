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

        Res.fetchDataNames { result in
            Names = result
            self.Res.Names = Names
            
        }
        Res.fetchDataLinks { result in
            Links = result
            self.Res.Links = Links
        }
        print("Social length \(Names.count)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
        
        let rvc = ResourceViewer()
        navigationController?.pushViewController(rvc, animated: true)
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
               
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
