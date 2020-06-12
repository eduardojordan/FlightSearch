//
//  CustomCellResults.swift
//  FlightSearch
//
//  Created by MAC on 08/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit

class CustomCellResults: UITableViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var flyNumberLabel: UILabel!
    @IBOutlet var regularFareLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
