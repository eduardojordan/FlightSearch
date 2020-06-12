//
//  ViewController.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SelectOriginDelegate, SelectDestinationDelegate, SelectDateDelegate {
    
    
    @IBOutlet var originStationButton: UIButton!
    @IBOutlet var destinationStationButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var departureButton: UIButton!
    
    @IBOutlet var viewAdults: UIView!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    
    @IBOutlet var plusTeenButto: UIButton!
    @IBOutlet var minusTeamButton: UIButton!
    @IBOutlet var viewTeen: UIView!
    
    @IBOutlet var plusChildrenButton: UIButton!
    @IBOutlet var minusChildrenButton: UIButton!
    @IBOutlet var viewChildren: UIView!
    
    @IBOutlet var adultsCounterLabel: UILabel!
    @IBOutlet var teenCounterLabel: UILabel!
    @IBOutlet var childrenCounterLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    var getOriginCode = ""
    var getOrigin = "" {
        didSet{
            self.originStationButton.setTitle(self.getOrigin, for: .normal)
            self.originStationButton.contentHorizontalAlignment = .left
        }
    }
    
    var getDestinationCode = ""
    var getDestination = "" {
        didSet{
            self.destinationStationButton.setTitle(self.getDestination, for: .normal)
            self.destinationStationButton.contentHorizontalAlignment = .left
        }
    }
    
    var getDateFligh = "" {
        didSet{
            self.dateLabel.text = getDateFligh
        }
    }
    
    var adultValue : Int = 1 {
        didSet{
            adultsCounterLabel.text = "\(adultValue)"
        }
    }
    
    var teenValue : Int = 0 {
        didSet{
            teenCounterLabel.text = "\(teenValue)"
        }
    }
    
    var childrenValue : Int = 0 {
        didSet{
            childrenCounterLabel.text = "\(childrenValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonActions()
        radiusButtons()
        
    }
    
    fileprivate func buttonActions() {
        originStationButton.addTarget(self, action: #selector(actionOrigin), for: .touchUpInside)
        destinationStationButton.addTarget(self, action: #selector(actionDestination), for: .touchUpInside)
        departureButton.addTarget(self, action: #selector(actionDate), for: .touchUpInside)
        
        plusButton.addTarget(self, action: #selector(actionPlus), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(actionMinus), for: .touchUpInside)
        
        plusTeenButto.addTarget(self, action: #selector(actionPlusGeneral), for: .touchUpInside)
        minusTeamButton.addTarget(self, action: #selector(actionMinusGeneral), for: .touchUpInside)
        
        plusChildrenButton.addTarget(self, action: #selector(actionPlusChildren), for: .touchUpInside)
        minusChildrenButton.addTarget(self, action: #selector(actionMinusChildren), for: .touchUpInside)
    }
    
    @objc func actionOrigin(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchAirportListViewController") as! SearchAirportListViewController
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @objc func actionDestination(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchAirportListViewController") as! SearchAirportListViewController
        controller.delegate2 = self
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @objc func actionDate(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        controller.delegateDate = self
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    @objc func actionPlus(){
        if adultValue < 6{
            adultValue += 1
        }
    }
    
    @objc func actionMinus(){
        if adultValue > 1{
            adultValue -= 1
        }
    }
    
    @objc func actionPlusGeneral(){
        if teenValue < 6{
            teenValue += 1
        }
    }
    
    @objc func actionMinusGeneral(){
        if teenValue > 0{
            teenValue -= 1
        }
    }
    
    @objc func actionPlusChildren(){
        if childrenValue < 6{
            childrenValue += 1
        }
    }
    
    @objc func actionMinusChildren(){
        if childrenValue > 0{
            childrenValue -= 1
        }
    }
    
    func selectStationOrigin(item: Stations) {
        self.getOrigin = item.name!.uppercased()
        self.getOriginCode = item.code!.uppercased()
        
    }
    
    func selectStationDestination(item: Stations) {
        self.getDestination = item.name!.uppercased()
        self.getDestinationCode = item.code!.uppercased()
    }
    
    func selectDate(item: String) {
        self.getDateFligh = item
    }
    
    
    func radiusButtons(){
        self.destinationStationButton.layer.cornerRadius = 20
        self.originStationButton.layer.cornerRadius = 20
        self.searchButton.layer.cornerRadius = 20
        self.departureButton.layer.cornerRadius = 20
        self.viewAdults.layer.cornerRadius = 20
        self.viewTeen.layer.cornerRadius = 20
        self.viewChildren.layer.cornerRadius = 20
        
    }
    
    
    @IBAction func ButtonSearch(_ sender: UIButton) {
        
        if getDateFligh == "" || getOriginCode == "" || getDestinationCode == "" {
            let alert = UIAlertController(title: "Attention", message: "Please fill in the fields Origin, Destination and Date fields for search ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
            controller.origin = getOriginCode
            controller.destination = getDestinationCode
            controller.date = getDateFligh
            controller.adults = String(adultValue)
            controller.teen = String(teenValue)
            controller.child = String(childrenValue)
            
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
}

