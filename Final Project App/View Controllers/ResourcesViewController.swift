//
//  ResourcesViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//


import Foundation
import UIKit
import WebKit

class ResourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var resources: [String]?
    var links: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        resources = ["one", "two", "three", "four"]
        links = ["https://code.org/", "https://code.org/", "https://code.org/", "https://code.org/", "https://code.org/"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = resources![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let rvc = ResourceViewer()
        navigationController?.pushViewController(rvc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prep 1")
        if let indexPath = tableView.indexPathForSelectedRow {
            print("prep 2")
            let destination = segue.destination as? ResourceViewer
            destination!.link = links![indexPath.row]
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
