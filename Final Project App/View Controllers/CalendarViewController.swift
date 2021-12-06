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
        
        Cal.fetchDataDates { result in
            self.Dates = result
            print("Just fetched dates the result is ", self.Dates)
            self.Cal.Dates = self.Dates
        }
        print("Dates length \(Dates.count)")
        Cal.fetchDataEvents { result in
            self.Events = result
            self.Cal.Events = self.Events
            //self.populateEvents()
        }
        print("Events length \(Events.count)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        while Dates.isEmpty == true{
            print("empty")
        }
        self.populateEvents()
    }

    @IBOutlet weak var EventList: UILabel!
    @IBAction func AddEvent(_ sender: Any) {
        //NewEvent = UITextField()
        if let eventText = NewEvent.text {
            if let event = Dict[SelectedDate] {
                var index = 0
                for n in 0...Dates.count - 1 {
                    if Dates[n] == SelectedDate {
                        index = n
                    }
                }
                Cal.Dates.remove(at: index)
                Cal.Events.remove(at: index)
                Cal.removeFromDates(name: SelectedDate)
                Cal.removeFromEvents(name: Dict[SelectedDate]!)
                Dict[SelectedDate]?.append(" & \(eventText)")
            }else{
                Dict[SelectedDate] = eventText
            }
//
            Cal.Dates.append(SelectedDate)
            Cal.Events.append(Dict[SelectedDate]!)
            Cal.addToDates(name: SelectedDate)
            Cal.addToEvents(name: Dict[SelectedDate]!)
            CalendarView.reloadData()
            EventList.text = Dict[SelectedDate]
            NewEvent.text = nil
            //NewEvent = nil
        }
        
    }

    @IBOutlet var NewEvent: UITextField!
    @IBAction func ClearEvents(_ sender: Any) {
        var index = 0
        for n in 0...Dates.count - 1 {
            if Dates[n] == SelectedDate {
                index = n
            }
        }
        guard Dict[SelectedDate] == nil else{
            Cal.Dates.remove(at: index)
            Cal.Events.remove(at: index)
            Cal.removeFromDates(name: SelectedDate)
            Cal.removeFromEvents(name: Dict[SelectedDate]!)
            CalendarView.reloadData()
            Dict[SelectedDate] = nil
            EventList.text = nil
            return
        }
    }
    
    
    func populateEvents() {
        for n in 0...Dates.count - 1 {
            Dict[Dates[n]] = Events[n]
        }

    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        print(string)
        SelectedDate = string
        if Dict[string] != nil {
            print(Dict[string]!)
        }
        EventList.text = Dict[string]
        EventList.sizeToFit()
    }

}
