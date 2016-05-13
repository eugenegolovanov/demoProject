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
        
        //New Style Constraints
//        let horizontalConstraint = spinner.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
//        let verticalConstraint = spinner.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
//        let widthConstraint = spinner.widthAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.width)
//        let heightConstraint = spinner.heightAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.height)
//        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        //Old Style Constraints
        spinner.translatesAutoresizingMaskIntoConstraints = false//swift 2.0
        let spinnerWidthConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerFrame.size.width)
        spinner.addConstraint(spinnerWidthConstraint)
        let spinnerHeightConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerFrame.size.height)
        spinner.addConstraint(spinnerHeightConstraint)
        let spinnerHorizontalConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.CenterX , relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(spinnerHorizontalConstraint)
        let spinnerVerticalConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.CenterY , relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.view.addConstraint(spinnerVerticalConstraint)


        

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