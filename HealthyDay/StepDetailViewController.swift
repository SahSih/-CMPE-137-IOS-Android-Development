//
//  StepDetailViewController.swift
//  HealthyDay
//
//  Created by Group 5 (MJD, NL, CP) on 10/8/16.
//  Copyright © 2016 San Jose State University. All rights reserved.
//

import UIKit

class StepDetailViewController: UIViewController {
    
    @IBOutlet weak var stepDetailView: StepDetailView!
    
    internal var stepCounts = [Int](){
        didSet{
            configureView()
        }
    }
    internal var distances = [Int](){
        didSet{
            print(distances)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Steps Details"
        automaticallyAdjustsScrollViewInsets = false
        configureView() 
    }
    
    private func configureView(){
        if stepCounts.count != 0 {
            if let view = stepDetailView {
                view.stepCountsData = stepCounts
            }
        }
    }
    
}

