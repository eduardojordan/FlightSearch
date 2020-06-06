//
//  CalendarViewController.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate {

    @IBOutlet var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let dateString = formatter.string(from: date)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        controller.dateSelect = dateString
            
        self.present(controller, animated: true, completion: nil)
        
        
    }
    
  


}
