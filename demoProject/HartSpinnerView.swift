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
    
    @IBInspectable var lineWidth: CGFloat = 2 {
        didSet {
            hartLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var strokeColor: UIColor = UIColor(red: 0.231, green: 0.741, blue: 0.792, alpha: 1.000) {
        didSet {
            hartLayer.strokeColor = strokeColor.CGColor
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.clearColor() {
        didSet {
            hartLayer.fillColor = fillColor.CGColor
        }
    }


    
    @IBInspectable var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    
    @IBInspectable var hartBeat: Bool = false {
        didSet {
            updateAnimation()
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
    
    @IBInspectable var shadowLayerMargin: CGFloat = 20 {
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
        setup()
    }

    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = UIColor.clearColor()
        hartLayer.lineWidth = lineWidth
        self.hartLayer.strokeColor = self.strokeColor.CGColor
        self.hartLayer.fillColor = self.fillColor.CGColor
        layer.addSublayer(hartLayer)
    }
    
    
    
    
    private func drawCanvas(frame frame: CGRect) {
        
        print("FRAME:\(frame)")


        
        let width:CGFloat = frame.size.width
        let height:CGFloat = frame.size.height
        print("WIDTH:\(width)")
        print("HEIGHT:\(height)")
        
        let minimumSide:CGFloat = min(width, height)
        print("Minimum side:\(minimumSide)")
        
        let bindPoseEtalonSide:CGFloat = 110
        let scale = minimumSide/bindPoseEtalonSide
        print("---+++---SCALE:\(scale)")
        
        
        //// Hart Drawing
        let hartPath = UIBezierPath()
        hartPath.moveToPoint(CGPointMake(scale * (frame.minX + 66.14), scale * (frame.minY + 79.1)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 107.86), scale * (frame.minY + 79.1)), controlPoint1: CGPointMake(scale * (frame.minX + 76.57), scale * (frame.minY + 69.02)), controlPoint2: CGPointMake(scale * (frame.minX + 97.09), scale * (frame.minY + 68.69)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 109.5), scale * (frame.minY + 80.82)), controlPoint1: CGPointMake(scale * (frame.minX + 108.44), scale * (frame.minY + 79.65)), controlPoint2: CGPointMake(scale * (frame.minX + 108.98), scale * (frame.minY + 80.23)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 111.14), scale * (frame.minY + 79.1)), controlPoint1: CGPointMake(scale * (frame.minX + 110.02), scale * (frame.minY + 80.23)), controlPoint2: CGPointMake(scale * (frame.minX + 110.56), scale * (frame.minY + 79.65)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 124.94), scale * (frame.minY + 71.57)), controlPoint1: CGPointMake(scale * (frame.minX + 115.09), scale * (frame.minY + 75.28)), controlPoint2: CGPointMake(scale * (frame.minX + 119.89), scale * (frame.minY + 72.77)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 152.86), scale * (frame.minY + 79.1)), controlPoint1: CGPointMake(scale * (frame.minX + 134.63), scale * (frame.minY + 69.28)), controlPoint2: CGPointMake(scale * (frame.minX + 145.29), scale * (frame.minY + 71.79)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 152.86), scale * (frame.minY + 119.4)), controlPoint1: CGPointMake(scale * (frame.minX + 164.38), scale * (frame.minY + 90.23)), controlPoint2: CGPointMake(scale * (frame.minX + 164.38), scale * (frame.minY + 108.27)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 110), scale * (frame.minY + 149.25)), controlPoint1: CGPointMake(scale * (frame.minX + 152.74), scale * (frame.minY + 119.52)), controlPoint2: CGPointMake(scale * (frame.minX + 127.06), scale * (frame.minY + 149.25)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 66.14), scale * (frame.minY + 119.4)), controlPoint1: CGPointMake(scale * (frame.minX + 93), scale * (frame.minY + 149.25)), controlPoint2: CGPointMake(scale * (frame.minX + 66.26), scale * (frame.minY + 119.52)))
        hartPath.addCurveToPoint(CGPointMake(scale * (frame.minX + 66.14), scale * (frame.minY + 79.1)), controlPoint1: CGPointMake(scale * (frame.minX + 54.62), scale * (frame.minY + 108.27)), controlPoint2: CGPointMake(scale * (frame.minX + 55.71), scale * (frame.minY + 89.17)))

        
        
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
    
    
    private func updateShadowLayer(margin:CGFloat) {
        if shadowLayer == nil {
            let radiusRect = CGRectMake(margin/2,
                                        margin/2,
                                        self.bounds.width - margin,
                                        self.bounds.height - margin)
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: radiusRect, cornerRadius: CGRectGetHeight(self.bounds) / 2.0).CGPath
            shadowLayer.fillColor = UIColor.whiteColor().CGColor
            shadowLayer.masksToBounds = false

            layer.shadowColor = shadowColor.CGColor
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = shadowOpacity
            layer.shadowOffset = shadowOffset

            
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
        self.drawCanvas(frame: newFrame)
        
        if shadowLayer == nil {
            self.updateShadowLayer(self.shadowLayerMargin)
        }
        

        

    }
    
    
    
}
