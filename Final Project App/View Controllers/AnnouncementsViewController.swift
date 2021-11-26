//
//  AnnouncementsViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit

//although right now, just planning on having different colors based on the announecemnt or other formatting stuff, could be used later for filtering and stuff
enum AnnouncementType{
    case Important, Social, Tournament
}

class ImportantCell: UITableViewCell{
    @IBOutlet weak var importantText: UILabel!
    
    @IBOutlet weak var importantTitle: UILabel!
}
class AnnouncementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Content of the announcements. Could later add the  button, but right now could have it added by the app runner people if an announcement needs to be made
    let announcementContent: [String] = ["Register for your USAU membership by 11/30/2021. You need to have registered for USAU in order to play in any games / tournaments next spring.", "Social gathering this Friday @ Waterman.", "Cars for Harvest: \n Car 1: Dori & Gabi \n Car 2: Lindsay and Irene", "Practice will be INDOORS this Thursday!"]
    let announcementType: [AnnouncementType] = [.Important,.Social,.Tournament, .Important]
    let titlesOfCells: [String] = ["Example of important announcement", "Example of social announcement", "Example of tournament annoucement", "Another important announcement"]
    //Important thing here is that there are 3 different arrays (guess I could have also done 1 array of arrays maybe a possibl change and adding/deleting needs to make sure to do to all 3
    
    // These are the colors of the square views in our table view cells.
    // In a real project you might use UIImages.
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"
    
   
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announcementContent.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:ImportantCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ImportantCell
        cell.importantTitle.text = self.titlesOfCells[indexPath.row]
        cell.importantText.text = self.announcementContent[indexPath.row]
        cell = configureCellByType(cellToEdit: cell, locationOfCell: indexPath.row)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150 
    }
    
    func configureCellByType(cellToEdit: ImportantCell, locationOfCell: Int) -> ImportantCell{
        let indexOfCell = locationOfCell
        //like way to match up by type
        //currently the configurations are limited to what I have here, but easy place to put all the updates
        //not that attached to how i have them now more a jumping off point for how we want it to look
        if(announcementType[indexOfCell] == .Important){
            cellToEdit.backgroundColor = UIColor.systemRed
            cellToEdit.backgroundColor = cellToEdit.backgroundColor?.withAlphaComponent(0.10)//light red to make it stand out
            //really just want to be able to change the boldness fo the font :(
            cellToEdit.importantTitle.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.bold) //size of all titles should be 19, it is the weight that I want to control, but could also adjust the size here if so pleased
            //note: order of boldness goes ultralight -> thin -> light -> regular -> medium -> semibold -> bold -> heavy -> black
            
            //other customizable configurations:
            
        }
        if(announcementType[indexOfCell] == .Social){
            cellToEdit.importantTitle.textColor = .systemPurple
        }
        if(announcementType[indexOfCell] == .Tournament){
            cellToEdit.importantTitle.textColor = .systemGreen
        }
        //social to be purple
        //tournament to be green
        
        return cellToEdit
    }
}
