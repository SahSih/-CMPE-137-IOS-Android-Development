//
//  DistanceWalkingRunningLabel.swift
//  HealthyDay
//
//  Created by Group 5 (MJD, NL, CP) on 10/8/16.
//  Copyright © 2016 San Jose State University. All rights reserved.
//

import UIKit

internal class DistanceWalkingRunningLabel: UILabel {
    
    private let nameLabel = UILabel()
    internal var subviewsAlpha : CGFloat = 1{
        didSet{
            for view in subviews {
                view.alpha = subviewsAlpha
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        textAlignment = .center
        textColor = UIColor.white
        adjustsFontSizeToFitWidth = true
        text = "0.00"
        font = UIFont(name: "DINCondensed-Bold", size: 90.0/320*frame.width)
        
        initNameLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initNameLabel(){
        
        guard nameLabel.superview == nil else{return}
        nameLabel.frame = CGRect(x: 0, y: frame.height*0.21, width: frame.width, height: frame.height*0.072)
        nameLabel.text = "Total Distance (Kilometers)"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.systemFont(ofSize: 17.0/320*frame.width)
        addSubview(nameLabel)
    }
}
