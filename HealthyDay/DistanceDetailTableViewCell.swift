//
//  DistanceDetailTableViewCell.swift
//  HealthyDay
//
//  Created by Group 5 (MJD, NL, CP) on 10/8/16.
//  Copyright © 2016 San Jose State University. All rights reserved.
//

import UIKit

internal class DistanceDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationPerKilometerLabel: UILabel!
    
    internal var date = Date(){
        didSet{
            dateLabel.text = getFormatDateDescription(fromDate: date)
        }
    }
    
    internal var distance : Double = 0{
        didSet{
            let text = NSMutableAttributedString(string: String(format: "%.2f", distance/1000.0), attributes: [
                NSFontAttributeName:UIFont(name: "DINCondensed-Bold", size: 37)!,
                ])
            let unitText = NSMutableAttributedString(string: "Kilometers", attributes: [
                NSFontAttributeName:UIFont.systemFont(ofSize: 14)
                ])
            text.append(unitText)
            distanceLabel.text = String(format: "%.2fkm", distance/1000.0)
            distanceLabel.attributedText = text
        }
    }
    
    internal var duration : Int = 0{
        didSet{
            durationLabel.text = durationFormatter(secondsDuration: duration)
        }
    }
    
    internal var durationPerKilometer : Int = 0{
        didSet{
            durationPerKilometerLabel.text = durationPerKilometerFormatter(secondsDurationPK: durationPerKilometer)
        }
    }

    private func getFormatDateDescription(fromDate date:Date)->String{
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        switch hour {
        case 0..<11:
            return String(day)+"h Morning"
        case 11..<14:
            return String(day)+"h Noon"
        case 14..<19:
            return String(day)+"h Afternoon"
        case 19..<25:
            return String(day)+"h Evening"
        default:
            fatalError("Hour should be in 0...24")
        }
    }
}
