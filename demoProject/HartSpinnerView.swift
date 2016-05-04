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

     let duration:CFTimeInterval = 1.5
    
    
    //MARK: Animation Properties
    
    private let strokeEndAnimation: CAAnimation = {
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.duration = 1
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let duration = 2.5
        let loopDuration = duration * 0.75

        let animation = CAKeyframeAnimation(keyPath: "strokeEnd")
        animation.values = [0.0, 0.5, 1.0]
        animation.keyTimes = [0.0, 0.5, 1.0]
        animation.duration = loopDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    private let strokeStartAnimation: CAAnimation = {
//        let animation = CABasicAnimation(keyPath: "strokeStart")
//        animation.beginTime = 0.5
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.duration = 1
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let duration = 2.5
        let loopDuration = duration * 0.75
        
        let animation = CAKeyframeAnimation(keyPath: "strokeStart")
        animation.beginTime = duration * 0.75 / 2
        animation.values = [0.0, 0.7, 1.0, 1.0]
        animation.keyTimes = [0.0, 0.5, 0.9, 1.0]
        animation.duration = loopDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        
        let group = CAAnimationGroup()
        group.duration = duration
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
//        self.hartLayer.fillColor = hartBlu.CGColor
        self.hartLayer.fillColor = UIColor.clearColor().CGColor
        layer.addSublayer(hartLayer)
        tintColorDidChange()
    }
    
    
    func drawCanvas(frame frame: CGRect, scale: CGFloat) {
        
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// hartPath Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, frame.minX + 0, frame.minY + 0)
        CGContextScaleCTM(context, 0.5, 0.5)

        //// Hart Drawing
        let hartPath = UIBezierPath()
        hartPath.moveToPoint(CGPointMake(scale * (frame.minX + 29.14), scale * (frame.minY + 30.08)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 29.14), scale * (frame.minY + 30.08)), controlPoint1: CGPointMake(scale * (frame.minX + 27.79), scale * (frame.minY + 31.22)), controlPoint2: CGPointMake(scale * (frame.minX + 28.45), scale * (frame.minY + 30.63)))

        hartPath.addLineToPoint(CGPointMake(scale * (frame.minX + 29.49), scale * (frame.minY + 29.81)))

        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 68.86), scale * (frame.minY + 31.85)), controlPoint1: CGPointMake(scale * (frame.minX + 41.07), scale * (frame.minY + 20.77)), controlPoint2: CGPointMake(scale * (frame.minX + 58.09), scale * (frame.minY + 21.44)))

        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 70.5), scale * (frame.minY + 33.57)), controlPoint1: CGPointMake(scale * (frame.minX + 69.44), scale * (frame.minY + 32.4)), controlPoint2: CGPointMake(scale * (frame.minX + 69.98), scale * (frame.minY + 32.98)))
        
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 72.14), scale * (frame.minY + 31.85)), controlPoint1: CGPointMake(scale * (frame.minX + 71.02), scale * (frame.minY + 32.98)), controlPoint2: CGPointMake(scale * (frame.minX + 71.56), scale * (frame.minY + 32.4)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 85.94), scale * (frame.minY + 24.32)), controlPoint1: CGPointMake(scale * (frame.minX + 76.09), scale * (frame.minY + 28.03)), controlPoint2: CGPointMake(scale * (frame.minX + 80.89), scale * (frame.minY + 25.52)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 113.86), scale * (frame.minY + 31.85)), controlPoint1: CGPointMake(scale * (frame.minX + 95.63), scale * (frame.minY + 22.03)), controlPoint2: CGPointMake(scale * (frame.minX + 106.29), scale * (frame.minY + 24.54)))
        
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 113.86), scale * (frame.minY + 72.15)), controlPoint1: CGPointMake(scale * (frame.minX + 125.38), scale * (frame.minY + 42.98)), controlPoint2: CGPointMake(scale * (frame.minX + 125.38), scale * (frame.minY + 61.02)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 113.49), scale * (frame.minY + 72.5)), controlPoint1: CGPointMake(scale * (frame.minX + 113.74), scale * (frame.minY + 72.27)), controlPoint2: CGPointMake(scale * (frame.minX + 113.62), scale * (frame.minY + 72.39)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 70), scale * (frame.minY + 102)), controlPoint1: CGPointMake(scale * (frame.minX + 113.5), scale * (frame.minY + 72.5)), controlPoint2: CGPointMake(scale * (frame.minX + 88), scale * (frame.minY + 102)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 27.5), scale * (frame.minY + 72.5)), controlPoint1: CGPointMake(scale * (frame.minX + 52.07), scale * (frame.minY + 102)), controlPoint2: CGPointMake(scale * (frame.minX + 27.68), scale * (frame.minY + 72.72)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 27.14), scale * (frame.minY + 72.15)), controlPoint1: CGPointMake(scale * (frame.minX + 27.38), scale * (frame.minY + 72.38)), controlPoint2: CGPointMake(scale * (frame.minX + 27.26), scale * (frame.minY + 72.27)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 27.14), scale * (frame.minY + 31.85)), controlPoint1: CGPointMake(scale * (frame.minX + 15.62), scale * (frame.minY + 61.02)), controlPoint2: CGPointMake(scale * (frame.minX + 15.62), scale * (frame.minY + 42.98)))
        hartPath.closePath()
        hartBlu.setFill()
        hartPath.fill()
        
        CGContextRestoreGState(context)

        
        
        let center = CGPoint(x: 0, y: 0)

        
        
        self.hartLayer.path = hartPath.CGPath
        self.hartLayer.lineCap = kCALineCapRound
        self.hartLayer.opacity = 1.0
        self.hartLayer.position = center

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
        
        print("Our frame is:\(self.frame)")
        
        let newFrame = CGRectMake(0, 0, self.frame.width/2, self.frame.height/2)
        
        print("NEW frame is:\(newFrame)")

        self.drawCanvas(frame: newFrame, scale: 0.7)
        
        

    }
}
