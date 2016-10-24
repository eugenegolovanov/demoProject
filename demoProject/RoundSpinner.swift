//
//  RoundSpinner.swift
//  spinners
//
//  Created by eugene golovanov on 10/20/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

@IBDesignable
class RoundSpinner: UIView {
    
    //---------------------------------------------------------------------------------------------------
    // MARK: - Properties
    
    let circleLayer = CAShapeLayer()
    let backgroundCircleLayer = CAShapeLayer()
    
    //Shadow
    var shadowLayer = CAShapeLayer()
    
    
    //Animation
    var duration:CFTimeInterval = 0.75 {
        didSet {
            circleLayer.removeAnimationForKey("transform.rotation.z")
            rotateAnimation.duration = self.duration
            circleLayer.addAnimation(rotateAnimation, forKey: "transform.rotation.z")
        }
    }
    
    private let rotateAnimation: CAAnimation = {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.duration = 1.0
        rotationAnim.repeatCount = Float.infinity
        rotationAnim.fromValue = 0.0
        rotationAnim.toValue = Float(M_PI * 2.0)
        rotationAnim.fillMode = kCAFillModeForwards
        rotationAnim.removedOnCompletion = false
        return rotationAnim
    }()
    
    
    
    @IBInspectable var lineWidth: CGFloat = 4 {
        didSet {
            circleLayer.lineWidth = lineWidth
            backgroundCircleLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var strokeColor: UIColor = UIColor(red: 59/255, green: 189/255, blue: 202/255, alpha: 1.0) {
        didSet {
            circleLayer.strokeColor = strokeColor.CGColor
        }
    }
    
    @IBInspectable var trailColor: UIColor = UIColor(red: 240/255, green: 243/255, blue: 245/255, alpha: 1.0) {
        didSet {
            backgroundCircleLayer.strokeColor = trailColor.CGColor
        }
    }
    
    @IBInspectable var bgColor: UIColor = UIColor.clearColor() {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    var trailAlpha: Float = 1.0 {
        didSet {
            backgroundCircleLayer.opacity = trailAlpha
        }
    }
    
    //Shadow
    @IBInspectable var shadowColor: UIColor = UIColor.lightGrayColor() {
        
        didSet {
            layer.shadowColor = shadowColor.CGColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSizeMake(0, 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowLayerMargin: CGFloat = 0 {
        didSet {
            self.updateShadowLayer(shadowLayerMargin)
        }
    }
    
    
    //---------------------------------------------------------------------------------------------------
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    //---------------------------------------------------------------------------------------------------
    // MARK: - Setup
    
    private func setup() {
        
        backgroundCircleLayer.lineWidth = lineWidth
        backgroundCircleLayer.fillColor = UIColor.clearColor().CGColor
        backgroundCircleLayer.strokeColor = UIColor(red: 240/255, green: 243/255, blue: 245/255, alpha: 1.0).CGColor
        
        layer.addSublayer(backgroundCircleLayer)
        
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(red: 59/255, green: 189/255, blue: 202/255, alpha: 1.0).CGColor
        
        layer.addSublayer(circleLayer)
        
        rotateAnimation.duration = self.duration
        circleLayer.addAnimation(rotateAnimation, forKey: "transform.rotation.z")
        
        tintColorDidChange()
    }
    
    private func updateShadowLayer(margin:CGFloat) {
        //        if shadowLayer == nil {
        let radiusRect = CGRectMake(margin/2,
                                    margin/2,
                                    self.bounds.width - margin,
                                    self.bounds.height - margin)
        //            shadowLayer = CAShapeLayer()
        //            shadowLayer.path = UIBezierPath(roundedRect: radiusRect, cornerRadius: CGRectGetHeight(self.bounds) / 2.0).CGPath
        shadowLayer.path = UIBezierPath(roundedRect: radiusRect, cornerRadius: CGRectGetHeight(self.bounds)).CGPath
        
        shadowLayer.fillColor = UIColor.whiteColor().CGColor
        shadowLayer.masksToBounds = false
        
        layer.shadowColor = shadowColor.CGColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.insertSublayer(shadowLayer, atIndex: 0)
        
        //        }
        
    }
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth/2
        
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = startAngle + CGFloat(M_PI * 2)
        
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundCircleLayer.lineCap = kCALineCapSquare
        backgroundCircleLayer.position = center
        backgroundCircleLayer.path = path.CGPath
        
        circleLayer.lineCap = kCALineCapRound
        circleLayer.position = center
        circleLayer.path = path.CGPath
        circleLayer.strokeEnd = 0.25
        
        //        if shadowLayer == nil {
        self.updateShadowLayer(self.shadowLayerMargin)
        //        }
        
    }
    
}
