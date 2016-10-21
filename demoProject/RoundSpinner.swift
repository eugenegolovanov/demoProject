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
    let circleLayer = CAShapeLayer()
    let backgroundCircleLayer = CAShapeLayer()
    
    private let rotateAnimation: CAAnimation = {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.duration = 2.0
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
    
    @IBInspectable var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    
    func updateAnimation() {
        if animating {
            circleLayer.addAnimation(rotateAnimation, forKey: "transform.rotation.z")
        }
        else {
            circleLayer.removeAnimationForKey("transform.rotation.z")
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
        backgroundCircleLayer.strokeColor = UIColor(red: 240/255, green: 243/255, blue: 245/255, alpha: 1.0).CGColor

        layer.addSublayer(backgroundCircleLayer)
        
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(red: 59/255, green: 189/255, blue: 202/255, alpha: 1.0).CGColor

        layer.addSublayer(circleLayer)
        tintColorDidChange()
    }
    
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
    }
}
