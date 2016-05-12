//
//  ExtendedVC+HartSpinner.swift
//  demoProject
//
//  Created by eugene golovanov on 5/12/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

extension ExtendedVC {
    
    
    /**
     Function creates 'HartSpinnerView' with animation and add it to the ViewControllers 'self.view'
     - add hart spinner:
     ```swift
     self.hartSpinnerStartAnimating()
     ```
     - remove hart spinner:
     ```swift
     self.hartSpinnerStopAnimating()

     */
    func hartSpinnerStartAnimating() {
        
        //Reset
        self.hartSpinnerStopAnimating()
        
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
    
    
    
    /**
     Function removes any 'HartSpinnerView' from 'self.view'
     - usage:
     ```
     self.hartSpinnerStopAnimating()
     */
    func hartSpinnerStopAnimating() {
        for view in self.view.subviews {
            if view.isKindOfClass(HartSpinnerView) {
                view.removeFromSuperview()
            }
        }
    }
    
    
    
    
    
}