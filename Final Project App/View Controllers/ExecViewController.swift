//
//  ExecViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit

class ExecViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var execView: UITableView!
    
    // captains, presidents,vice president, treasurer
    let execBoard = [["Meg Eisfelder","Izzy Singer","Mia Cuda","Lauren Sands","Jacqui Escatel"],["Via Poolos","Cynthia Chang"],["Irene Zhou"],["Raiyan Hamilton"]]
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewContainer = UIView(frame: CGRect(x:0, y:0, width: execView.frame.width, height: 40))
        viewContainer.backgroundColor = UIColor.lightGray
        let labelHeader = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 30))

        labelHeader.textColor = UIColor.white
        if section == 0{
            labelHeader.text = " Captains"
        }
        if section == 1{
            labelHeader.text =  " Presidents"
        }
        if section == 2{
            labelHeader.text =  " Vice President"
        }
        if section == 3{
            labelHeader.text =  " Treasurer"
        }
                    
        viewContainer.addSubview(labelHeader)
        return viewContainer
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return execBoard.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return execBoard[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "execCell", for: indexPath)
        
        cell.textLabel?.text = String(execBoard[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = execBoard[indexPath.section][indexPath.row]
        let individualExec = IndividualExecViewController()
        individualExec.person = person
        let section = indexPath.section
        var position = ""
        if section == 0{
            position = " Captains"
        }
        if section == 1{
            position =  " Presidents"
        }
        if section == 2{
            position =  " Vice President"
        }
        if section == 3{
            position =  " Treasurer"
        }
        
        individualExec.position = position
        
        self.navigationController?.pushViewController(individualExec, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.execView.delegate = self
        self.execView.dataSource = self

    }
  

}
