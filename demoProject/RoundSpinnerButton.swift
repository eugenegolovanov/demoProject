//
//  RoundSpinnerButton.swift
//  spinners
//
//  Created by eugene golovanov on 10/21/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//  

import UIKit


@IBDesignable
public class RoundSpinnerButton: UIButton {
    

    @IBInspectable public var roundRectCornerRadius: CGFloat = 2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var roundRectColor: UIColor = UIColor(red: 74/255, green: 149/255, blue: 255/255, alpha: 1.0) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var pressed:CGFloat = 0 {
        didSet {
                self.titleLabel?.alpha = pressed
        }
    }
    
    var spinner = RoundSpinner()
    
    public override func awakeFromNib() {
        let spinnerSize:CGFloat = 24
        self.spinner.frame = CGRect(x: self.frame.size.width/2 - spinnerSize/2, y: self.frame.size.height/2 - spinnerSize/2, width: spinnerSize, height: spinnerSize)
        self.spinner.strokeColor = UIColor.whiteColor()
        self.spinner.trailColor = UIColor.whiteColor()
        self.spinner.trailAlpha = 0.2
        self.spinner.lineWidth = 2.0
        self.spinner.shadowLayer.opacity = 0
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        
        let spinnerWidthConstraint = NSLayoutConstraint(item: self.spinner, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerSize)
        self.spinner.addConstraint(spinnerWidthConstraint)
        let spinnerHeightConstraint = NSLayoutConstraint(item: self.spinner, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: spinnerSize)
        self.spinner.addConstraint(spinnerHeightConstraint)
        let spinnerHorizontalConstraint = NSLayoutConstraint(item: self.spinner, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(spinnerHorizontalConstraint)
        let spinnerVerticalConstraint = NSLayoutConstraint(item: self.spinner, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.addConstraint(spinnerVerticalConstraint)

        
        self.titleLabel?.alpha = CGFloat(!self.pressSpin)
        self.spinner.alpha = CGFloat(self.pressSpin)

    }
    
    
    public var pressSpin:Bool = false {
        didSet{
            UIView.animateWithDuration(0.2) { 
                self.titleLabel?.alpha = CGFloat(!self.pressSpin)
                self.spinner.alpha = CGFloat(self.pressSpin)
            }
        }
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutRoundRectLayer()
    }
    
    
    private var roundRectLayer: CAShapeLayer?
    
    private func layoutRoundRectLayer() {
        if let existingLayer = roundRectLayer {
            existingLayer.removeFromSuperlayer()
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: roundRectCornerRadius).CGPath
        shapeLayer.fillColor = roundRectColor.CGColor
        self.layer.insertSublayer(shapeLayer, atIndex: 0)
        self.roundRectLayer = shapeLayer
    }
}


//MARK: Tap Functionality
extension RoundSpinnerButton {
    private func addGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RoundSpinnerButton.handleIconTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func handleIconTapped(sender:UITapGestureRecognizer) {
        sendActionsForControlEvents(.TouchUpInside)//Send Event Like UIButton
    }
    
    
    //Change Color While TAP
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        animateTintAdjustmentMode(.Dimmed)
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        animateTintAdjustmentMode(.Normal)
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        animateTintAdjustmentMode(.Normal)
        self.pressSpin = !self.pressSpin
    }
    
    private func animateTintAdjustmentMode(mode: UIViewTintAdjustmentMode) {
        
        UIView.animateWithDuration(mode == .Normal ? 0.3 : 0.01) {
            self.tintAdjustmentMode = mode
        }
    }
    
    
}
