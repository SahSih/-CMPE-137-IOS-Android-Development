//
//  Theme.swift
//  HealthyDay
//
//  Created by Group 5 (MJD, NL, CP) on 10/8/16.
//  Copyright © 2016 San Jose State University. All rights reserved.
//

import Foundation
import UIKit

internal final class Theme {
    
    static let shared = Theme()
    
    let lightThemeColor = rgbColor(red:0x36, green:0xB9, blue: 0xF2, alpha: 1)
    let darkThemeColor = rgbColor(red: 0x3A, green: 0xA5, blue: 0xD2, alpha: 1)
    let translucentLightThemeColor = rgbColor(red:0x36, green:0xB9, blue: 0xF2, alpha: 0.5)
    
    let lightTextColor = UIColor.lightGray
    let darkTextColor = UIColor.darkGray
    
    let lightLineChartColor = rgbColor(red: 0xFF, green: 0xFF, blue: 0xFF, alpha: 0.5)
    let thickLineChartColor = rgbColor(red: 0x13, green: 0xDC, blue: 0xFA, alpha: 0.5)
    
    let lightSplitLineColor = rgbColor(red: 0xE3, green: 0xE3, blue: 0xE3, alpha: 1)
    let thickSplitLineColor = rgbColor(red: 0xDF, green: 0xDF, blue: 0xDF, alpha: 1)
    
    private init(){}
    
    
    
}
