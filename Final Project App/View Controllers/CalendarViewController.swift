//
//  CalendarViewController.swift
//  Final Project App
//
//  Created by Irene Zhou on 11/6/21.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDelegateAppearance {
    @IBOutlet weak var CalendarView: FSCalendar!
    var Events: [String : String] = [:]
    var SelectedDate:String = " "
    var EnteredEvent:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        CalendarView.delegate = self
        populateEvents()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let today = formatter.string(from: CalendarView.today!)
        SelectedDate = today
        EventList.text = Events[today]
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var EventList: UILabel!
    @IBAction func AddEvent(_ sender: Any) {
        
    }
    @IBAction func NewEvent(_ sender: Any) {
        if let event = Events[SelectedDate] {
            Events[SelectedDate] = event + "\n" + "new event"
        }
    }
    @IBAction func ClearEvents(_ sender: Any) {
        Events[SelectedDate] = nil
    }
    
    
    func populateEvents() {
        Events["Tuesday 12-07-2021"] = "Practice 7-9 PM"
        Events["Thursday 12-09-2021"] = "Practice 6:30-8:30PM"
        Events["Sunday 12-12-2021"] = "Ice Skating at 8PM"
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        print(string)
        SelectedDate = string
        if Events[string] != nil {
            print(Events[string]!)
        }
        EventList.text = Events[string]
        EventList.sizeToFit()
    }
    
    func calendar(_ _calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        if Events[string] != nil {
            return UIColor.init(displayP3Red: 0, green: 0.5, blue: 0.5, alpha: 0.5)
        }else {
            return nil
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
