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
    func hartSpinnerStartAnimating(mainView mainView: UIView) {
        
        //Reset
        self.hartSpinnerStopAnimating(mainView: mainView)
        
        let spinnerFrame = CGRectMake(0, 0, 80, 80)
        let spinner = HartSpinnerView(frame: spinnerFrame)
        spinner.animating = true
        spinner.hartBeat = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(spinner)
        
        //New Style Constraints
//        let horizontalConstraint = spinner.centerXAnchor.constraintEqualToAnchor(mainView.centerXAnchor)
//        let verticalConstraint = spinner.centerYAnchor.constraintEqualToAnchor(mainView.centerYAnchor)
//        let widthConstraint = spinner.widthAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.width)
//        let heightConstraint = spinner.heightAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.height)
//        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        //Old Style Constraints
        spinner.translatesAutoresizingMaskIntoConstraints = false//swift 2.0
        let spinnerWidthConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerFrame.size.width)
        spinner.addConstraint(spinnerWidthConstraint)
        let spinnerHeightConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerFrame.size.height)
        spinner.addConstraint(spinnerHeightConstraint)
        let spinnerHorizontalConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.CenterX , relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        mainView.addConstraint(spinnerHorizontalConstraint)
        let spinnerVerticalConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.CenterY , relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        mainView.addConstraint(spinnerVerticalConstraint)

    }
    
    
    
    /**
     Function removes any 'HartSpinnerView' from 'self.view'
     - usage:
     ```
     self.hartSpinnerStopAnimating()
     */
    func hartSpinnerStopAnimating(mainView mainView:UIView) {
        for view in mainView.subviews {
            if view.isKindOfClass(HartSpinnerView) {
                view.removeFromSuperview()
            }
        }
    }
    
    
    
    
    
}