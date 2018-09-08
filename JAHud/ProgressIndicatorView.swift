//
//  ProgressIndicatorView.swift
//  JAHub
//
//  Created by Shane Whitehead on 7/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import Foundation
import UIKit

class ProgressIndicatorView: AnimatableView {
	
	internal struct Keys {
		static let progressAnimation = "Key.progressAnimation"
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 54, height: 54)
	}

	// Used to maintain a consistent frame rate
	internal var displayLink: CADisplayLink!
	internal var currentProgress: Double = 0.0
	
	internal var progressShape: CAShapeLayer = CAShapeLayer()
	
	var isAnimating: Bool {
		return !displayLink.isPaused
	}
	
	var progress: Progress?
	
	var strokeColor: UIColor = UIColor.darkGray {
		didSet {
			progressShape.strokeColor = strokeColor.cgColor
		}
	}
	
	var strokeWidth: CGFloat = 3.0 {
		didSet {
			progressShape.lineWidth = strokeWidth
		}
	}
	
	var strokeCap: CAShapeLayerLineCap = CAShapeLayerLineCap.round {
		didSet {
			progressShape.lineCap = strokeCap
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	internal func commonInit() {
		displayLink = CADisplayLink(target: self, selector: #selector(animationDidUpdate))
		displayLink.preferredFramesPerSecond = 60
		displayLink.add(to: .current, forMode: RunLoop.Mode.default)
		displayLink.isPaused = true
		
		progressShape.strokeColor = strokeColor.cgColor
		progressShape.lineWidth = strokeWidth
		progressShape.lineCap = strokeCap
		progressShape.lineJoin = .round
		progressShape.strokeStart = 0
		progressShape.strokeEnd = 0
		progressShape.path = UIBezierPath(ovalIn: frame).cgPath
		progressShape.frame = bounds
		progressShape.fillColor = nil
		
		layer.addSublayer(progressShape)
		
		backgroundColor = nil
		isOpaque = false
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()

		let width = bounds.size.width
		let height = bounds.size.height
		
		let centerX = width / 2.0
		let centerY = height / 2.0
		let middle = CGPoint(x: centerX, y: centerY)
		let radius = min(width, height) / 2
		
		let startAt = -90.toRadians
		let endAt = CGFloat((360.0 - 90.0).toRadians)
		
		progressShape.path = UIBezierPath(arcCenter: middle, radius: radius, startAngle: startAt, endAngle: endAt, clockwise: true).cgPath
		progressShape.frame = bounds
	}
	
	override public func startAnimating() {
		displayLink.isPaused = false
	}
	
	override  public func stopAnimating() {
		displayLink.isPaused = true
	}
	
	@objc func animationDidUpdate(displayLink: CADisplayLink) {
		guard let progress = progress else {
			return
		}
		guard currentProgress != progress.fractionCompleted else {
			return
		}
		currentProgress = progress.fractionCompleted
		
		// This is a little covaluted, sorry.  Basically, the desire was to have the "progress" be animatable as well
		// but because the progress can change, it need to be able handle these changes as well
		// I've seperated the progress animation out (using a separate CADisplayLink)
		animate(progress: currentProgress)
	}
	
	func animate(progress: Double) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(0.3)
		CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut))
		
		// Wonder if we can chain existing animations :/
		progressShape.removeAnimation(forKey: Keys.progressAnimation)
		
		progressShape.strokeEnd = CGFloat(progress)
		
		let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
		animation.fromValue = progressShape.strokeEnd
		animation.toValue = CGFloat(progress)
		//animation.duration = 0.3
		//animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		//progressShape.add(animation, forKey: Keys.progressAnimation)
		
		CATransaction.commit()
	}
}
