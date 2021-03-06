//
//  AnnouncementsViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit
import Firebase
//although right now, just planning on having different colors based on the announecemnt or other formatting stuff, could be used later for filtering and stuff
enum AnnouncementType{
    case Important, Social, Tournament
}

class ImportantCell: UITableViewCell{
    @IBOutlet weak var importantText: UILabel!
    @IBOutlet var postedByText: UILabel!
    @IBOutlet weak var importantTitle: UILabel!
}
class AnnouncementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var db = Firestore.firestore()
    
    // Content of the announcements. Could later add the  button, but right now could have it added by the app runner people if an announcement needs to be made
    var announcementContent: [String] = []
    var announcementType: [String] = []
    var titlesOfCells: [String] = []
    var announcementPoster: [String] = []
    var typeDone = false
    var contentDone = false
    var titleDone = false
    
    //Important thing here is that there are 3 different arrays (guess I could have also done 1 array of arrays maybe a possibl change and adding/deleting needs to make sure to do to all 3
    
    // These are the colors of the square views in our table view cells.
    // In a real project you might use UIImages.
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"
    
   
    @IBOutlet var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchDataAnnouncementType{ type in
            self.announcementType = type
        }
        
        fetchDataAnnouncementTitle{ title in
            self.titlesOfCells = title
        }
        
        
        
        fetchDataPostedBy { result in
            self.announcementPoster = result
        }
        
        fetchDataAnnouncementContent { result in
            self.announcementContent = result
            self.tableView.reloadData()
        }
        
        self.navigationItem.hidesBackButton = false
        self.parent?.title = "ANNOUNCEMENTS"
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.announcementContent = []
                self.announcementType = []
                self.titlesOfCells = []
                self.announcementPoster = []
                
                self.fetchDataAnnouncementType{ type in
                    self.announcementType = type
                    
                    self.typeDone = true
                }
                
                self.fetchDataAnnouncementTitle{ title in
                    self.titlesOfCells = title
                    
                    self.titleDone = true
                }
                
                self.fetchDataPostedBy { result in
                    self.announcementPoster = result
                }
                
                self.fetchDataAnnouncementContent { result in
                    self.announcementContent = result
                    
                    self.tableView.reloadData()
                }
                
                
           }
        }
    }
    
     
   
    override func viewDidAppear(_ animated: Bool) {
        /*while(self.announcementContent.count == 0){
            print("hello")
        }*/
        self.tableView.reloadData()
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announcementContent.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastCellNumber = announcementContent.count - 1
        var cell:ImportantCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ImportantCell
        cell.importantTitle.text = self.titlesOfCells[lastCellNumber - indexPath.row]
        cell.importantText.text = self.announcementContent[lastCellNumber - indexPath.row]
        cell.postedByText.text = "Posted by: " + self.announcementPoster[lastCellNumber - indexPath.row]
        cell.importantText.text = cell.importantText.text?.replacingOccurrences(of: "\\n", with: "\n")
        cell.importantText.text = cell.importantText.text?.replacingOccurrences(of: "x2v6mo8", with: ",")
        cell = configureCellByType(cellToEdit: cell, locationOfCell: lastCellNumber - indexPath.row)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        if(announcementType[indexOfCell] == "Important"){
            cellToEdit.backgroundColor = UIColor.systemRed
            cellToEdit.backgroundColor = cellToEdit.backgroundColor?.withAlphaComponent(0.10)//light red to make it stand out
            //really just want to be able to change the boldness fo the font :(
            cellToEdit.importantTitle.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.bold) //size of all titles should be 19, it is the weight that I want to control, but could also adjust the size here if so pleased
            //note: order of boldness goes ultralight -> thin -> light -> regular -> medium -> semibold -> bold -> heavy -> black
            
            
        }
        if(announcementType[indexOfCell] == "Social"){
            cellToEdit.importantTitle.textColor = .systemPurple
        }
        if(announcementType[indexOfCell] == "Tournament"){
            cellToEdit.importantTitle.textColor = .systemGreen
        }
        //social to be purple
        //tournament to be green
        
        return cellToEdit
    }

    func fetchDataAnnouncementType(_ completion: @escaping ([String]) -> Void){
        let docRefAnnouncementType = db.collection("announcements").document("AnnouncementType")
        docRefAnnouncementType.getDocument{(document, error) in
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachType = String()
                
                
                let semaphore = DispatchSemaphore(value: 0)
                
                DispatchQueue.global().async {
                    for items in pureData{
                        if(items == "("){
                            semaphore.signal()
                        }
                        
                        else if(items == ","){
                            self.announcementType.append(String(eachType))
                            eachType.removeAll()
                            semaphore.signal()
                        }
                        else if(items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachType.append(items)
                            semaphore.signal()
                        }
                        
                        
                    }
                    self.announcementType.append(String(eachType))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        completion(self.announcementType)
                    }
                }
                
                
               
            }
            else{
                
            }
        }
    }
    
    func fetchDataAnnouncementTitle(_ completion: @escaping ([String]) -> Void){
        let docRefAnnouncementT = db.collection("announcements").document("AnnouncementTitle")
        docRefAnnouncementT.getDocument{(document, error) in
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachTitle = String()
                
                
                let semaphore = DispatchSemaphore(value: 0)
                
                DispatchQueue.global().async {
                    for items in pureData{
                        if(items == "("){
                            semaphore.signal()
                        }
                        
                        else if(items == ","){
                            self.titlesOfCells.append(String(eachTitle))
                            eachTitle.removeAll()
                            semaphore.signal()
                        }
                        else if(items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachTitle.append(items)
                            semaphore.signal()
                        }
                        
                        
                    }
                    
                    self.titlesOfCells.append(String(eachTitle))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        completion(self.titlesOfCells)
                    }
                }
                
                
               
            }
            else{
                //do nothing
            }
        }
    }
    
    
    func fetchDataPostedBy(_ completion: @escaping ([String]) -> Void){
        let docRefAnnouncementT = db.collection("announcements").document("AnnouncementPoster")
        docRefAnnouncementT.getDocument{(document, error) in
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachPoster = String()
                
                
                let semaphore = DispatchSemaphore(value: 0)
                
                DispatchQueue.global().async {
                    for items in pureData{
                        if(items == "("){
                            semaphore.signal()
                        }
                        
                        else if(items == ","){
                            self.announcementPoster.append(String(eachPoster))
                            eachPoster.removeAll()
                            semaphore.signal()
                        }
                        else if(items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachPoster.append(items)
                            semaphore.signal()
                        }
                        
                        
                    }
                    
                    self.announcementPoster.append(String(eachPoster))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        completion(self.announcementPoster)
                    }
                }
                
                
               
            }
            else{
                //do nothing
            }
        }
    }
    
    
    func fetchDataAnnouncementContent(_ completion: @escaping ([String]) -> Void){
        let docRefAnnouncementC = db.collection("announcements").document("AnnouncementContent")
        docRefAnnouncementC.getDocument{(document, error) in
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let begin = dataDescription.firstIndex(of: "(")
                let end = dataDescription.firstIndex(of: ")")
                let range = begin!..<end!
                let pureData = dataDescription[range]
                
                var eachContent = String()
                
                
                let semaphore = DispatchSemaphore(value: 0)
                
                DispatchQueue.global().async {
                    for items in pureData{
                        if(items == "("){
                            semaphore.signal()
                        }
                        
                        else if(items == ","){
                            self.announcementContent.append(String(eachContent))
                            eachContent.removeAll()
                            semaphore.signal()
                        }
                        else if(items == "\n"){
                            semaphore.signal()
                        }
                        else{
                            eachContent.append(items)
                            semaphore.signal()
                        }
                        
                        
                    }
                    
                    self.announcementContent.append(String(eachContent))
                    semaphore.wait()
                    
                    DispatchQueue.main.async {
                        completion(self.announcementContent)
                    }
                }
                
                
               
            }
            else{
                //do nothing
            }
        }
        
        
        
    }
}

