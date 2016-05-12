//
//  ExtendedVC+HartSpinner.swift
//  demoProject
//
//  Created by eugene golovanov on 5/12/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

extension ExtendedVC {
    
    func addHartSpinner() {
        let spinnerFrame = CGRectMake(0, 0, 80, 80)
        let spinner = HartSpinnerView(frame: spinnerFrame)
        spinner.animating = true
        spinner.hartBeat = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        let horizontalConstraint = spinner.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let verticalConstraint = spinner.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
        let widthConstraint = spinner.widthAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.width)
        let heightConstraint = spinner.heightAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.height)
        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
}