//
//  DistanceStatisticsChartBar.swift
//  HealthyDay
//
//  Created by Group 5 (MJD, NL, CP) on 10/8/16.
//  Copyright © 2016 San Jose State University. All rights reserved.
//

import UIKit

class DistanceStatisticsChartBar: UIView {
//MARK: IBOutlet
    @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var barInfoLabel: UILabel!
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var barBottom: UIView!
    @IBOutlet weak var barTitleLabel: UILabel!
//MARK: Property
    internal var barInfo = ""{
        didSet{
            barInfoLabel.text = barInfo
        }
    }
    internal var barHeight : CGFloat = 0{
        didSet{
            barHeightConstraint.constant = barHeight
            layoutIfNeeded()
            barBottom.backgroundColor = barHeight == 0 ? theme.translucentLightThemeColor : theme.lightThemeColor
        }
    }
    
    internal var barTitle = ""{
        didSet{
            barTitleLabel.text = barTitle
        }
    }
//MARK: View
    override func awakeFromNib() {
        bar.backgroundColor = theme.lightThemeColor
    }
}
