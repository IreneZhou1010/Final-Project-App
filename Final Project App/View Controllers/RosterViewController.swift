//
//  RosterViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit
import Firebase

// pull data from firebase to populate
// let ref = Database.database().reference(withPath: "roster")
var IHRoster:[String] = []
var LocaRoster:[String] = []
private var db = Firestore.firestore()


class RosterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var rosterView: UITableView!
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var addIH: UIButton!
    @IBOutlet weak var addLoca: UIButton!
    
    var Ros = Roster()
    
    var roster = [[String](),[String]()]
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewContainer = UIView(frame: CGRect(x:0, y:0, width: rosterView.frame.width, height: 40))
        viewContainer.backgroundColor = UIColor.lightGray
        let labelHeader = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 30))

        labelHeader.textColor = UIColor.white
        if section == 0{
            labelHeader.text = " Iron Horse "
        }
        if section == 1{
            labelHeader.text =  " Locamotive"
        }
                    
        viewContainer.addSubview(labelHeader)
        return viewContainer
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return roster.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return roster[section].count
        }
        return roster[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rosterCell", for: indexPath)
        if indexPath.section == 0{
            cell.textLabel?.text = String(roster[indexPath.section][indexPath.row])
        }
        if indexPath.section == 1{
            cell.textLabel?.text = String(roster[indexPath.section][indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if indexPath.section == 0 {
                // IH
                Ros.IH.remove(at: indexPath.row)
                Ros.removeFromIH(name: roster[indexPath.section][indexPath.row])
            }
            else{
                // Loca
                Ros.Loca.remove(at: indexPath.row)
                Ros.removeFromLoca(name: roster[indexPath.section][indexPath.row])
            }
            roster[indexPath.section].remove(at: indexPath.row)
            self.rosterView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rosterView.delegate = self
        self.rosterView.dataSource = self
        search.isHidden = true
        Ros.fetchDataIH { result in
            IHRoster = result
            self.Ros.IH = IHRoster
            self.roster = [IHRoster,LocaRoster]
        }
        Ros.fetchDataLoca { result in
            LocaRoster = result
            self.Ros.Loca = LocaRoster
            self.roster = [IHRoster,LocaRoster]
        }
        
        
    
        
        
        //view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.rosterView.reloadData()
    }
    
    
    @IBAction func addIHPressed(_ sender: Any) {
        if (search.isHidden == true){
            search.isHidden = false
            
        }
        else{
            if let name = search.text {
                Ros.IH.append(name)
                Ros.addToIH(name: name)
                roster = [Ros.IH, Ros.Loca]
            }
            
            self.rosterView.reloadData()
            
            search.text = ""
            search.isHidden = true
        }
        
    }
    
    
    @IBAction func addLocaPressed(_ sender: Any) {
        if (search.isHidden == true){
            search.isHidden = false
            
        }
        else{
            if let name = search.text {
                Ros.Loca.append(name)
                Ros.addToLoca(name: name)
                roster = [Ros.IH, Ros.Loca]
            }
            
                self.rosterView.reloadData()
            

            search.text = ""
            search.isHidden = true

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
