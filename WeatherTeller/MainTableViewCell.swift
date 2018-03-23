//
//  MainTableViewCell.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-17.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelDegrees: UILabel!
    
    func setLocationInfo(location: Location) {
        labelLocation.text = location.title
        labelDegrees.text = String(location.degrees)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
