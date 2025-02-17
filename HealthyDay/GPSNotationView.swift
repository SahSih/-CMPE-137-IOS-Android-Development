//
//  GPSNotationView.swift
//  HealthyDay
//
//  Created by Group 5 (MJD, NL, CP) on 10/8/16.
//  Copyright © 2016 San Jose State University. All rights reserved.
//

import UIKit

internal class GPSNotationView: UIView {

    private let gpsNotation = UILabel()
    private let infoLabel = UILabel()
    
    internal var hasEnabled = false{
        didSet{

            if hasEnabled {
                gpsNotation.layer.backgroundColor = UIColor.green.cgColor
                infoLabel.text = getCurrentDateDescription()
            }else{
                gpsNotation.layer.backgroundColor = UIColor.red.cgColor
                infoLabel.text = "GPS Out Of Service"
            }
        }
    }
    
    internal init(frame:CGRect, hasEnabled:Bool){
        super.init(frame: frame)
        assert(frame.width > 100)
        
        backgroundColor = UIColor(white: 0.2, alpha: 0.3)
        layer.cornerRadius = frame.height/2
        
        let gap :CGFloat = 2
        gpsNotation.frame = CGRect(x: 0, y: gap, width: 30, height: frame.height-gap*2)
        gpsNotation.layer.cornerRadius = frame.height/2
        gpsNotation.layer.backgroundColor = UIColor.red.cgColor
        gpsNotation.text = "GPS"
        gpsNotation.textAlignment = .center
        gpsNotation.textColor = UIColor.black
        gpsNotation.font = UIFont.systemFont(ofSize: 14)
        addSubview(gpsNotation)
        
        infoLabel.frame = CGRect(x: gpsNotation.frame.maxX, y: gap, width: frame.width-gpsNotation.frame.maxX, height: frame.height-gap*2)
        infoLabel.textAlignment = .center
        infoLabel.textColor = UIColor.black
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "GPS Out Of Service"
        addSubview(infoLabel)
        self.hasEnabled = hasEnabled
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getCurrentDateDescription()->String{
        let date = Date().formatDescription()
        let timeRange = date.index(date.startIndex, offsetBy: 11)..<date.index(date.startIndex, offsetBy: 16)
        let dateArray = date.substring(to: date.index(date.startIndex, offsetBy: 10)).components(separatedBy: "-")
        
        let time = date.substring(with: timeRange)
        assert(dateArray.count == 3)
        return dateArray[0]+"Year"+dateArray[1]+"Month"+dateArray[2]+"Day "+time
    }
    
    internal func refreshCurrentTime(){
        infoLabel.text = getCurrentDateDescription()
    }
    
}
