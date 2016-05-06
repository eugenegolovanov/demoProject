//
//  StepsLoader.swift
//  demoProject
//
//  Created by eugene golovanov on 5/5/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit


@IBDesignable
class StepsLoader: UIView {
    let circleLayer = CAShapeLayer()
    let backgroundCircleLayer = CAShapeLayer()
    
    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
//    let strokeStartAnimation: CAAnimation = {
//        let animation = CABasicAnimation(keyPath: "strokeStart")
//        animation.beginTime = 0.5
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.duration = 1
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        
//        let group = CAAnimationGroup()
//        group.duration = 1.5
//        group.repeatCount = MAXFLOAT
//        group.animations = [animation]
//        
//        return group
//    }()
    
    @IBInspectable var lineWidth: CGFloat = 20 {
        didSet {
            circleLayer.lineWidth = lineWidth
            backgroundCircleLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        circleLayer.strokeColor = tintColor.CGColor
    }
    
    func updateAnimation() {
        if animating {
            circleLayer.addAnimation(strokeEndAnimation, forKey: "strokeEnd")
//            circleLayer.addAnimation(strokeStartAnimation, forKey: "strokeStart")
        }
        else {
            circleLayer.removeAnimationForKey("strokeEnd")
//            circleLayer.removeAnimationForKey("strokeStart")
        }
    }
    
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
    
    func setup() {
        
        backgroundCircleLayer.lineWidth = lineWidth
        backgroundCircleLayer.fillColor = UIColor.clearColor().CGColor
        backgroundCircleLayer.strokeColor = UIColor.lightGrayColor().CGColor
        layer.addSublayer(backgroundCircleLayer)

        
        
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(red: 0.8078, green: 0.2549, blue: 0.2392, alpha: 1.0).CGColor
        layer.addSublayer(circleLayer)
        tintColorDidChange()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth/2
        
        let startAngle = CGFloat(-M_PI_2) * 2.5
        let endAngle = startAngle + CGFloat(M_PI * 1.5)
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundCircleLayer.lineCap = kCALineCapRound
        backgroundCircleLayer.position = center
        backgroundCircleLayer.path = path.CGPath

        circleLayer.lineCap = kCALineCapRound
        circleLayer.position = center
        circleLayer.path = path.CGPath
        circleLayer.strokeEnd = 0.0
    }
}
