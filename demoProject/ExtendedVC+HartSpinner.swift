//
//  ExtendedVC+HartSpinner.swift
//  demoProject
//
//  Created by eugene golovanov on 5/12/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

extension ExtendedVC {
    
    
//    /**
//     Function creates 'HartSpinnerView' with animation and add it to the ViewControllers 'self.view'
//     - add hart spinner:
//     ```swift
//     self.hartSpinnerStartAnimating()
//     ```
//     - remove hart spinner:
//     ```swift
//     self.hartSpinnerStopAnimating()
//
//     */
//    func hartSpinnerStartAnimating(mainView mainView: UIView) {
//        
//        //Reset
//        self.hartSpinnerStopAnimating(mainView: mainView)
//
//        let spinnerFrame = CGRectMake(0, 0, 80, 80)
//        let spinner = HartSpinnerView(frame: spinnerFrame)
//        spinner.animating = true
//        spinner.hartBeat = false
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        mainView.addSubview(spinner)
//        
//        //New Style Constraints
////        let horizontalConstraint = spinner.centerXAnchor.constraintEqualToAnchor(mainView.centerXAnchor)
////        let verticalConstraint = spinner.centerYAnchor.constraintEqualToAnchor(mainView.centerYAnchor)
////        let widthConstraint = spinner.widthAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.width)
////        let heightConstraint = spinner.heightAnchor.constraintEqualToAnchor(nil, constant: spinnerFrame.size.height)
////        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//        
//        //Old Style Constraints
//        spinner.translatesAutoresizingMaskIntoConstraints = false//swift 2.0
//        let spinnerWidthConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerFrame.size.width)
//        spinner.addConstraint(spinnerWidthConstraint)
//        let spinnerHeightConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerFrame.size.height)
//        spinner.addConstraint(spinnerHeightConstraint)
//        let spinnerHorizontalConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.CenterX , relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
//        mainView.addConstraint(spinnerHorizontalConstraint)
//        let spinnerVerticalConstraint = NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.CenterY , relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
//        mainView.addConstraint(spinnerVerticalConstraint)
//
//    }
//    
//    
//    
//    /**
//     Function removes any 'HartSpinnerView' from 'self.view'
//     - usage:
//     ```
//     self.hartSpinnerStopAnimating()
//     */
//    func hartSpinnerStopAnimating(mainView mainView:UIView) {
//        for view in mainView.subviews {
//            if view.isKindOfClass(HartSpinnerView) {
//                view.removeFromSuperview()
//            }
//        }
//    }
    
    
    
    

    func hartSpinnerStartAnimating(mainView mainView: UIView) {
        
        //Reset
        self.hartSpinnerStopAnimating(mainView: mainView)

        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = view.center
        mainView.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        
        
        //Old Style Constraints
        indicator.translatesAutoresizingMaskIntoConstraints = false//swift 2.0
        let spinnerWidthConstraint = NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: indicator.frame.width)
        indicator.addConstraint(spinnerWidthConstraint)
        let spinnerHeightConstraint = NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: indicator.frame.height)
        indicator.addConstraint(spinnerHeightConstraint)
        let spinnerHorizontalConstraint = NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.CenterX , relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        mainView.addConstraint(spinnerHorizontalConstraint)
        let spinnerVerticalConstraint = NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.CenterY , relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        mainView.addConstraint(spinnerVerticalConstraint)

        indicator.color = UIColor.darkGrayColor()
        indicator.transform = CGAffineTransformMakeScale(0.75, 0.75);
        indicator.startAnimating()
        
        //Network Activity
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true


    }
    
    
    
    func hartSpinnerStopAnimating(mainView mainView:UIView) {
        for view in mainView.subviews {
            if view.isKindOfClass(UIActivityIndicatorView) {
                view.removeFromSuperview()
                //Network Activity
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            }
        }
    }

    
    
    
    
}