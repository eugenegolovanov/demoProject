//
//  HartSpinner.swift
//  hartLoader
//
//  Created by eugene golovanov on 5/2/16.
//  Copyright © 2016 EG. All rights reserved.
//

import UIKit


@IBDesignable
class HartSpinnerView: UIView {
    
    //------------------------------------------------------------------------------
    //MARK: - Properties

    
    //// Color Declarations
    private let hartBlu = UIColor(red: 0.231, green: 0.741, blue: 0.792, alpha: 1.000)
    private let hartBlueberry = UIColor(red: 0.290, green: 0.584, blue: 1.000, alpha: 1.000)

    
    private let hartLayer = CAShapeLayer()
    private let backgroundHartLayer = CAShapeLayer()
    
    
    //MARK: Inspectable Properties
    
    @IBInspectable var lineWidth: CGFloat = 4 {
        didSet {
            hartLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    
    @IBInspectable var hartBeat: Bool = true {
        didSet {
            updateAnimation()
        }
    }

    
    
    
    //MARK: Animation Properties
    
    private let strokeEndAnimation: CAAnimation = {
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
    
    private let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
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

    
    
    
    
    
    
    private let hartBeatAnimation: CAAnimation = {
        
        let scaleAnimate:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 1
        scaleAnimate.toValue = 0.95
        scaleAnimate.duration = 1.1
//        scaleAnimate.delegate = self
        scaleAnimate.repeatCount = Float.infinity
        scaleAnimate.removedOnCompletion = true
        scaleAnimate.setValue("scaleAnim", forKey: "name")
        scaleAnimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = MAXFLOAT
        group.animations = [scaleAnimate]
        
        return group
    }()

    
    

    
    
    
    
    //------------------------------------------------------------------------------
    //MARK: - init Methods

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
        hartLayer.lineWidth = lineWidth
        self.hartLayer.strokeColor = hartBlueberry.CGColor
        self.hartLayer.fillColor = hartBlu.CGColor
        layer.addSublayer(hartLayer)
        tintColorDidChange()
    }

    
    
    //------------------------------------------------------------------------------
    //MARK: - Helper Methods

    
    
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        hartLayer.strokeColor = tintColor.CGColor
    }
    
   private func updateAnimation() {
        if animating {
            hartLayer.hidden = false
            hartLayer.addAnimation(strokeEndAnimation, forKey: "strokeEnd")
            hartLayer.addAnimation(strokeStartAnimation, forKey: "strokeStart")
        }
        else {
            hartLayer.hidden = true
            hartLayer.removeAnimationForKey("strokeEnd")
            hartLayer.removeAnimationForKey("strokeStart")
        }
        
        
        
        if hartBeat {
            hartLayer.addAnimation(hartBeatAnimation, forKey: "transform.scale")
        }
        else {
            hartLayer.removeAnimationForKey("transform.scale")
        }

        
    }

    
    
    
    //------------------------------------------------------------------------------
    //MARK: - View Lifecycle

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: 0, y: 0)
        
        
        //// Hart Drawing
        let hartPath = UIBezierPath()
        hartPath.moveToPoint(CGPointMake(70.5, 33.57))
        hartPath.addCurveToPoint(CGPointMake(70.5, 33.57), controlPoint1: CGPointMake(69.44, 32.4), controlPoint2: CGPointMake(69.98, 32.98))
        
        hartPath.addCurveToPoint(CGPointMake(72.14, 31.85), controlPoint1: CGPointMake(71.02, 32.98), controlPoint2: CGPointMake(71.56, 32.4))
        hartPath.addCurveToPoint(CGPointMake(85.94, 24.32), controlPoint1: CGPointMake(76.09, 28.03), controlPoint2: CGPointMake(80.89, 25.52))
        hartPath.addCurveToPoint(CGPointMake(113.86, 31.85), controlPoint1: CGPointMake(95.63, 22.03), controlPoint2: CGPointMake(106.29, 24.54))
        
        hartPath.addCurveToPoint(CGPointMake(113.86, 72.15), controlPoint1: CGPointMake(125.38, 42.98), controlPoint2: CGPointMake(125.38, 61.02))
        hartPath.addCurveToPoint(CGPointMake(113.49, 72.5), controlPoint1: CGPointMake(113.74, 72.27), controlPoint2: CGPointMake(113.62, 72.39))
        hartPath.addCurveToPoint(CGPointMake(70, 102), controlPoint1: CGPointMake(113.5, 72.5), controlPoint2: CGPointMake(88, 102))
        hartPath.addCurveToPoint(CGPointMake(27.5, 72.5), controlPoint1: CGPointMake(52.07, 102), controlPoint2: CGPointMake(27.68, 72.72))
        hartPath.addCurveToPoint(CGPointMake(27.14, 72.15), controlPoint1: CGPointMake(27.38, 72.38), controlPoint2: CGPointMake(27.26, 72.27))
        hartPath.addCurveToPoint(CGPointMake(27.14, 31.85), controlPoint1: CGPointMake(15.62, 61.02), controlPoint2: CGPointMake(15.62, 42.98))
        hartPath.addCurveToPoint(CGPointMake(29.14, 30.08), controlPoint1: CGPointMake(27.79, 31.22), controlPoint2: CGPointMake(28.45, 30.63))
        hartPath.addLineToPoint(CGPointMake(29.49, 29.81))
        hartPath.addCurveToPoint(CGPointMake(68.86, 31.85), controlPoint1: CGPointMake(41.07, 20.77), controlPoint2: CGPointMake(58.09, 21.44))
        hartPath.closePath()
        hartBlu.setFill()
        hartPath.fill()
        
        
        
        self.hartLayer.path = hartPath.CGPath
        self.hartLayer.lineCap = kCALineCapRound
        self.hartLayer.opacity = 1.0

        hartLayer.position = center
        

    }
}
