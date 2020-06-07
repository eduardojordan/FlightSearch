//
//  CalendarViewController.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit
import FSCalendar

protocol SelectDateDelegate: NSObjectProtocol {
    func selectDate(item: String)
}

class CalendarViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet var calendar: FSCalendar!
    
    var delegateDate: SelectDateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let dateString = formatter.string(from: date)
        delegateDate?.selectDate(item: dateString)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}
