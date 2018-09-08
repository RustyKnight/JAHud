//
//  MaterialWaitIndicator.swift
//  JAHud
//
//  Created by Shane Whitehead on 8/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import UIKit

class MaterialWaitIndicatorView: AnimatableView {
	
	struct Keys {
		static let strokeAnimationKey: String = "Key.stroke"
		static let rotationAnimationKey: String = "Key.rotation"
	}
	
	// default is YES. calls -setHidden when animating gets set to NO
	public var hidesWhenStopped:Bool = true {
		didSet{
			isHidden = !isAnimating && hidesWhenStopped
		}
	}
	
	public var strokeColor: UIColor = UIColor.black {
		didSet {
			progressLayer.strokeColor = strokeColor.cgColor
		}
	}
	
	/** Sets the line width of the  circle. */
	public var strokeWidth: CGFloat = 3 {
		didSet{
			progressLayer.lineWidth = strokeWidth
			updatePath()
		}
	}
	
	/** Sets the line cap of the circle. */
	public var lineCap: CAShapeLayerLineCap = .round {
		didSet{
			progressLayer.lineCap = lineCap
			updatePath()
		}
	}
	
	/** Specifies the timing function to use for the control's animation. Defaults to kCAMediaTimingFunctionEaseInEaseOut */
	var timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
	
	/** Property indicating the duration of the animation, default is 1.5s. Should be set prior to -[startAnimating] */
	public var duration: TimeInterval = 1.5
	
	/** Property to manually set the percent complete of the spinner, in case you don't want to start at 0. Valid values are 0.0 to 1.0 */
	public var progress: Double = 0 {
		didSet{
			if isAnimating {
				return
			}
			
			progressLayer.strokeStart = 0.0
			progressLayer.strokeEnd = CGFloat(progress)
		}
	}
	
	lazy var isAnimating: Bool = false
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	override public func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit(){
		hidesWhenStopped = true
		duration = 1.5
		progress = 0.0
		timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		progressLayer.strokeColor = strokeColor.cgColor
		progressLayer.lineWidth = strokeWidth

		layer.addSublayer(progressLayer)
		
		// See comment in resetAnimations on why this notification is used.
		NotificationCenter.default.addObserver(self, selector:#selector(resetAnimations),
																					 name: UIApplication.didBecomeActiveNotification,
																					 object: nil)
		
		invalidateIntrinsicContentSize()
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		progressLayer.frame = bounds
		invalidateIntrinsicContentSize()
		updatePath()
	}
	
	private func intrinsicContentSize() -> CGSize {
		return CGSize.init(width: bounds.width, height: bounds.height)
	}
	
	@objc private func resetAnimations(){
		// If the app goes to the background, returning it to the foreground causes the animation to stop (even though it's not explicitly stopped by our code). Resetting the animation seems to kick it back into gear.
		if (isAnimating) {
			stopAnimating()
			startAnimating()
		}
	}
	
	public func setAnimating(_ animate: Bool){
		(animate ? startAnimating() : stopAnimating())
	}
	
	
	override public func startAnimating() {
		guard !isAnimating else {
			return
		}
		let animation:CABasicAnimation = CABasicAnimation()
		animation.keyPath = "transform.rotation"
		animation.duration = duration / 0.375
		animation.fromValue = 0
		animation.toValue = Double.pi * 2
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false
		progressLayer.add(animation, forKey: Keys.strokeAnimationKey)
		
		let headAnimation:CABasicAnimation = CABasicAnimation()
		headAnimation.keyPath = "strokeStart"
		headAnimation.duration = duration / 1.5
		headAnimation.fromValue = 0.0
		headAnimation.toValue = 0.25
		headAnimation.timingFunction = timingFunction
		
		let tailAnimation:CABasicAnimation = CABasicAnimation()
		tailAnimation.keyPath = "strokeEnd"
		tailAnimation.duration = duration / 1.5
		tailAnimation.fromValue = 0.0
		tailAnimation.toValue = 1.0
		tailAnimation.timingFunction = timingFunction
		
		let endHeadAnimation:CABasicAnimation = CABasicAnimation()
		endHeadAnimation.keyPath = "strokeStart"
		endHeadAnimation.beginTime = duration / 1.5
		endHeadAnimation.duration = duration / 3.0
		endHeadAnimation.fromValue = 0.25
		endHeadAnimation.toValue = 1.0
		endHeadAnimation.timingFunction = timingFunction
		
		let endTailAnimation:CABasicAnimation = CABasicAnimation()
		endTailAnimation.keyPath = "strokeEnd"
		endTailAnimation.beginTime = duration / 1.5
		endTailAnimation.duration = duration / 3.0
		endTailAnimation.fromValue = 1.0
		endTailAnimation.toValue = 1.0
		endTailAnimation.timingFunction = timingFunction
		
		let animations:CAAnimationGroup = CAAnimationGroup()
		animations.duration = duration
		animations.animations = [headAnimation,tailAnimation,endHeadAnimation,endTailAnimation]
		animations.repeatCount = .infinity
		animations.isRemovedOnCompletion = false
		progressLayer.add(animations, forKey: Keys.rotationAnimationKey)
		
		
		isAnimating = true;
		
		if hidesWhenStopped {
			isHidden = false;
		}
	}
	
	override public func stopAnimating() {
		guard isAnimating else {
			return
		}
		progressLayer.removeAnimation(forKey: Keys.strokeAnimationKey)
		progressLayer.removeAnimation(forKey: Keys.rotationAnimationKey)
		isAnimating = false;
		
		if hidesWhenStopped {
			isHidden = true
		}
	}
	
	private func updatePath() {
		let center: CGPoint = CGPoint.init(x: bounds.midX, y: bounds.midY)
		let radius: CGFloat = min(bounds.width * 0.5, bounds.height * 0.5 - progressLayer.lineWidth * 0.5)
		let startAngle: CGFloat = CGFloat(0)
		let endAngle = CGFloat(Double.pi * 2)
		
		let path:UIBezierPath = UIBezierPath.init(arcCenter: center,
																							radius: radius,
																							startAngle: startAngle,
																							endAngle: endAngle,
																							clockwise: true)
		progressLayer.path = path.cgPath
		
		progressLayer.strokeStart = 0.0
		progressLayer.strokeEnd = CGFloat(progress)
	}
	
	lazy var progressLayer: CAShapeLayer = {
		let layer:CAShapeLayer = CAShapeLayer()
		layer.strokeColor = tintColor.cgColor
		layer.fillColor = nil
		layer.lineWidth = 1.5
		
		return layer
	}()
	
}
