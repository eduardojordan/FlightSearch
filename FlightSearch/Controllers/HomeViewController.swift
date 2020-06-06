//
//  ViewController.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SelectOriginDelegate, SelectDestinationDelegate {
    
    
    @IBOutlet var originStationButton: UIButton!
    @IBOutlet var destinationStationButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var departureButton: UIButton!
    @IBOutlet var adultsButton: UIButton!
    @IBOutlet var teenButton: UIButton!
    @IBOutlet var chidrenButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    var getOrigin = ""{
        didSet{
            self.originStationButton.setTitle(self.getOrigin, for: .normal)
            self.originStationButton.contentHorizontalAlignment = .left
        }
    }
    
    var getDestination = ""{
        didSet{
            self.destinationStationButton.setTitle(self.getDestination, for: .normal)
            self.destinationStationButton.contentHorizontalAlignment = .left
        }
    }
    
    var dateSelect:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originStationButton.addTarget(self, action: #selector(actionOrigin), for: .touchUpInside)
        destinationStationButton.addTarget(self, action: #selector(actionDestination), for: .touchUpInside)
        departureButton.addTarget(self, action: #selector(actionDate), for: .touchUpInside)
        radiusButtons()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dateLabel.text = dateSelect
    }
    
    @objc func actionOrigin(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchAirportListViewController") as! SearchAirportListViewController
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @objc func actionDestination(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchAirportListViewController") as! SearchAirportListViewController
        controller.delegate2 = self
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @objc func actionDate(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func selectStationOrigin(item: Stations) {
        self.getOrigin = item.name.uppercased()
    }
    
    func selectStationDestination(item: Stations) {
        self.getDestination = item.name.uppercased()
    }
    
    func radiusButtons(){
        self.destinationStationButton.layer.cornerRadius = 20
        self.originStationButton.layer.cornerRadius = 20
        self.searchButton.layer.cornerRadius = 20
        self.departureButton.layer.cornerRadius = 20
        self.adultsButton.layer.cornerRadius = 20
        self.teenButton.layer.cornerRadius = 20
        self.chidrenButton.layer.cornerRadius = 20
    }
    
    
    @IBAction func ButtonSearch(_ sender: UIButton) {
        
    }
    
    
}

