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
    var Dates: [String] = []
    var Events: [String] = []
    var Dict: [String: String] = [:]
    //var Events: [String : String] = [:]
    var SelectedDate:String = " "
    var EnteredEvent:String?
    var Cal = Calendar()

    override func viewDidLoad() {
        super.viewDidLoad()
        CalendarView.delegate = self
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let today = formatter.string(from: CalendarView.today!)
        SelectedDate = today
        //EventList.text = Events[today]
        
        Cal.fetchDataDates { result in
            self.Dates = result
            self.Cal.Dates = self.Dates
        }
        print("Dates length \(Dates.count)")
        Cal.fetchDataEvents { result in
            self.Events = result
            self.Cal.Events = self.Events
        }
        print("Events length \(Events.count)")
        populateEvents()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var EventList: UILabel!
    @IBAction func AddEvent(_ sender: Any) {
        if let eventText = NewEvent.text {
            if let event = Dict[SelectedDate] {
                Dict[SelectedDate] = event + " \n" + eventText
            }else{
                Dict[SelectedDate] = eventText
            }
//            if let event = Events[SelectedDate] {
//                Events[SelectedDate] = event + " \n" + eventText
//            }else{
//                Events[SelectedDate] = eventText
//            }
            NewEvent.text = nil
            CalendarView.reloadData()
            //EventList.text = Events[SelectedDate]
        }
        
    }
    @IBOutlet weak var NewEvent: UITextField!
    @IBAction func ClearEvents(_ sender: Any) {
        Dict[SelectedDate] = nil
        //Events[SelectedDate] = nil
        //EventList.text = nil
        CalendarView.reloadData()
    }
    
    
    func populateEvents() {
        for n in 0...Dates.count {
            Dict[Dates[n]] = Events[n]
        }
//        Events["Tuesday 12-07-2021"] = "Practice 7-9 PM"
//        Events["Thursday 12-09-2021"] = "Practice 6:30-8:30PM"
//        Events["Sunday 12-12-2021"] = "Ice Skating at 8PM"
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        print(string)
        SelectedDate = string
//        if Events[string] != nil {
//            print(Events[string]!)
//        }
//        EventList.text = Events[string]
        if Dict[string] != nil {
            print(Dict[string]!)
        }
        EventList.text = Dict[string]
        EventList.sizeToFit()
    }
    
    func calendar(_ _calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        if Dict[string] != nil {
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
