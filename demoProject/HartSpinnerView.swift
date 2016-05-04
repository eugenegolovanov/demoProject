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
    
    
    var shadowLayer: CAShapeLayer!
    
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
    
    @IBInspectable var strokeColor: UIColor = UIColor.yellowColor() {
        didSet {
            hartLayer.strokeColor = strokeColor.CGColor
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.greenColor() {
        didSet {
            hartLayer.fillColor = fillColor.CGColor
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
    

    //Shadow
    @IBInspectable var shadowColor: UIColor = UIColor.blackColor() {
        didSet {
            layer.shadowColor = shadowColor.CGColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowLayerMargin: CGFloat = 10 {
        didSet {
            self.updateShadowLayer(shadowLayerMargin)
        }
    }


    
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
        //Corner Radius
//        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2.0
//        self.layer.masksToBounds = true

        setup()
    }

    
    func setup() {
        hartLayer.lineWidth = lineWidth
//        self.hartLayer.strokeColor = hartBlueberry.CGColor
//        self.hartLayer.fillColor = UIColor.clearColor().CGColor
        
        self.hartLayer.strokeColor = self.strokeColor.CGColor
        self.hartLayer.fillColor = self.fillColor.CGColor

        layer.addSublayer(hartLayer)
//        tintColorDidChange()
    }
    
    
    
    
    func drawCanvas(frame frame: CGRect, scale: CGFloat) {
        
        print("FRAME:\(frame)")

        //// Hart Drawing
        let hartPath = UIBezierPath()
//        hartPath.moveToPoint(CGPointMake(frame.minX + 68.49, frame.minY + 69.81))
//        hartPath.addLineToPoint(CGPointMake(frame.minX + 68.49, frame.minY + 69.81))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 107.86, frame.minY + 71.85), controlPoint1: CGPointMake(frame.minX + 80.07, frame.minY + 60.77), controlPoint2: CGPointMake(frame.minX + 97.09, frame.minY + 61.44))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 109.5, frame.minY + 73.57), controlPoint1: CGPointMake(frame.minX + 108.44, frame.minY + 72.4), controlPoint2: CGPointMake(frame.minX + 108.98, frame.minY + 72.98))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 111.14, frame.minY + 71.85), controlPoint1: CGPointMake(frame.minX + 110.02, frame.minY + 72.98), controlPoint2: CGPointMake(frame.minX + 110.56, frame.minY + 72.4))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 124.94, frame.minY + 64.32), controlPoint1: CGPointMake(frame.minX + 115.09, frame.minY + 68.03), controlPoint2: CGPointMake(frame.minX + 119.89, frame.minY + 65.52))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 152.86, frame.minY + 71.85), controlPoint1: CGPointMake(frame.minX + 134.63, frame.minY + 62.03), controlPoint2: CGPointMake(frame.minX + 145.29, frame.minY + 64.54))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 152.86, frame.minY + 112.15), controlPoint1: CGPointMake(frame.minX + 164.38, frame.minY + 82.98), controlPoint2: CGPointMake(frame.minX + 164.38, frame.minY + 101.02))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 152.49, frame.minY + 112.5), controlPoint1: CGPointMake(frame.minX + 152.74, frame.minY + 112.27), controlPoint2: CGPointMake(frame.minX + 152.62, frame.minY + 112.39))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 109, frame.minY + 142), controlPoint1: CGPointMake(frame.minX + 152.5, frame.minY + 112.5), controlPoint2: CGPointMake(frame.minX + 127, frame.minY + 142))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 66.5, frame.minY + 112.5), controlPoint1: CGPointMake(frame.minX + 91.07, frame.minY + 142), controlPoint2: CGPointMake(frame.minX + 66.68, frame.minY + 112.72))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 66.14, frame.minY + 112.15), controlPoint1: CGPointMake(frame.minX + 66.38, frame.minY + 112.38), controlPoint2: CGPointMake(frame.minX + 66.26, frame.minY + 112.27))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 66.14, frame.minY + 71.85), controlPoint1: CGPointMake(frame.minX + 54.62, frame.minY + 101.02), controlPoint2: CGPointMake(frame.minX + 54.62, frame.minY + 82.98))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 68.14, frame.minY + 70.08), controlPoint1: CGPointMake(frame.minX + 66.79, frame.minY + 71.22), controlPoint2: CGPointMake(frame.minX + 67.45, frame.minY + 70.63))

        
//        hartPath.moveToPoint(CGPointMake(frame.minX + 153.86, frame.minY + 78.85))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 153.86, frame.minY + 119.15), controlPoint1: CGPointMake(frame.minX + 165.38, frame.minY + 89.98), controlPoint2: CGPointMake(frame.minX + 165.38, frame.minY + 108.02))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 153.49, frame.minY + 119.5), controlPoint1: CGPointMake(frame.minX + 153.74, frame.minY + 119.27), controlPoint2: CGPointMake(frame.minX + 153.62, frame.minY + 119.39))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 110, frame.minY + 149), controlPoint1: CGPointMake(frame.minX + 153.5, frame.minY + 119.5), controlPoint2: CGPointMake(frame.minX + 128, frame.minY + 149))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 67.5, frame.minY + 119.5), controlPoint1: CGPointMake(frame.minX + 92.07, frame.minY + 149), controlPoint2: CGPointMake(frame.minX + 67.68, frame.minY + 119.72))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 67.14, frame.minY + 119.15), controlPoint1: CGPointMake(frame.minX + 67.38, frame.minY + 119.38), controlPoint2: CGPointMake(frame.minX + 67.26, frame.minY + 119.27))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 67.14, frame.minY + 78.85), controlPoint1: CGPointMake(frame.minX + 55.62, frame.minY + 108.02), controlPoint2: CGPointMake(frame.minX + 55.62, frame.minY + 89.98))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 69.14, frame.minY + 77.08), controlPoint1: CGPointMake(frame.minX + 67.79, frame.minY + 78.22), controlPoint2: CGPointMake(frame.minX + 68.45, frame.minY + 77.63))
//        hartPath.addLineToPoint(CGPointMake(frame.minX + 69.49, frame.minY + 76.81))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 108.86, frame.minY + 78.85), controlPoint1: CGPointMake(frame.minX + 81.07, frame.minY + 67.77), controlPoint2: CGPointMake(frame.minX + 98.09, frame.minY + 68.44))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 110.5, frame.minY + 80.57), controlPoint1: CGPointMake(frame.minX + 109.44, frame.minY + 79.4), controlPoint2: CGPointMake(frame.minX + 109.98, frame.minY + 79.98))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 112.14, frame.minY + 78.85), controlPoint1: CGPointMake(frame.minX + 111.02, frame.minY + 79.98), controlPoint2: CGPointMake(frame.minX + 111.56, frame.minY + 79.4))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 125.94, frame.minY + 71.32), controlPoint1: CGPointMake(frame.minX + 116.09, frame.minY + 75.03), controlPoint2: CGPointMake(frame.minX + 120.89, frame.minY + 72.52))
//        hartPath.addCurveToPoint(CGPointMake(frame.minX + 153.86, frame.minY + 78.85), controlPoint1: CGPointMake(frame.minX + 135.63, frame.minY + 69.03), controlPoint2: CGPointMake(frame.minX + 146.29, frame.minY + 71.54))

        
        hartPath.moveToPoint(CGPointMake(frame.minX + 71.14, frame.minY + 74.33))
        
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 71.14, frame.minY + 74.33), controlPoint1: CGPointMake(frame.minX + 69.79, frame.minY + 75.47), controlPoint2: CGPointMake(frame.minX + 70.45, frame.minY + 74.88))
        hartPath.addLineToPoint(CGPointMake(frame.minX + 71.49, frame.minY + 74.06))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 110.86, frame.minY + 76.1), controlPoint1: CGPointMake(frame.minX + 83.07, frame.minY + 65.02), controlPoint2: CGPointMake(frame.minX + 100.09, frame.minY + 65.69))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 112.5, frame.minY + 77.82), controlPoint1: CGPointMake(frame.minX + 111.44, frame.minY + 76.65), controlPoint2: CGPointMake(frame.minX + 111.98, frame.minY + 77.23))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 114.14, frame.minY + 76.1), controlPoint1: CGPointMake(frame.minX + 113.02, frame.minY + 77.23), controlPoint2: CGPointMake(frame.minX + 113.56, frame.minY + 76.65))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 127.94, frame.minY + 68.57), controlPoint1: CGPointMake(frame.minX + 118.09, frame.minY + 72.28), controlPoint2: CGPointMake(frame.minX + 122.89, frame.minY + 69.77))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 155.86, frame.minY + 76.1), controlPoint1: CGPointMake(frame.minX + 137.63, frame.minY + 66.28), controlPoint2: CGPointMake(frame.minX + 148.29, frame.minY + 68.79))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 155.86, frame.minY + 116.4), controlPoint1: CGPointMake(frame.minX + 167.38, frame.minY + 87.23), controlPoint2: CGPointMake(frame.minX + 167.38, frame.minY + 105.27))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 113, frame.minY + 146.25), controlPoint1: CGPointMake(frame.minX + 155.74, frame.minY + 116.52), controlPoint2: CGPointMake(frame.minX + 130.06, frame.minY + 146.25))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 69.14, frame.minY + 116.4), controlPoint1: CGPointMake(frame.minX + 96, frame.minY + 146.25), controlPoint2: CGPointMake(frame.minX + 69.26, frame.minY + 116.52))
        hartPath.addCurveToPoint(CGPointMake(frame.minX + 69.14, frame.minY + 76.1), controlPoint1: CGPointMake(frame.minX + 57.62, frame.minY + 105.27), controlPoint2: CGPointMake(frame.minX + 57.62, frame.minY + 87.23))
        
        
        

        
        hartPath.closePath()
        hartBlu.setFill()
        hartPath.fill()
        
        
        
        let center = CGPoint(x: 0, y: 0)


        
        
        self.hartLayer.path = hartPath.CGPath
        self.hartLayer.lineCap = kCALineCapRound
        self.hartLayer.opacity = 1.0
        self.hartLayer.position = center
        
        


    }

    
    
    //------------------------------------------------------------------------------
    //MARK: - Helper Methods

    
    
    
//    override func tintColorDidChange() {
//        super.tintColorDidChange()
////        hartLayer.strokeColor = tintColor.CGColor
//        self.hartLayer.strokeColor = self.strokeColor.CGColor
//        self.hartLayer.fillColor = self.fillColor.CGColor
//
//    }
    
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
    
    
    func updateShadowLayer(margin:CGFloat) {
        if shadowLayer == nil {
            let radiusRect = CGRectMake(margin/2,
                                        margin/2,
                                        self.bounds.width - margin,
                                        self.bounds.height - margin)
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: radiusRect, cornerRadius: CGRectGetHeight(self.bounds) / 2.0).CGPath
            shadowLayer.fillColor = UIColor.whiteColor().CGColor
            layer.insertSublayer(shadowLayer, atIndex: 0)

        }
        
    }


    
    
    
    //------------------------------------------------------------------------------
    //MARK: - View Lifecycle

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("Our frame is:\(self.frame)")
        
        let newFrame = CGRectMake(0, 0, self.frame.width/2, self.frame.height/2)
        print("NEW frame is:\(newFrame)")
        self.drawCanvas(frame: newFrame, scale: 1.0)
        
//        self.drawCanvas(frame: self.frame, scale: 1.0)

        
        
        if shadowLayer == nil {
            self.updateShadowLayer(self.shadowLayerMargin)
            layer.insertSublayer(shadowLayer, atIndex: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }

        

    }
    
    
    
}
