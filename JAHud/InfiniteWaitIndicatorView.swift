//
//  InfiniteWaitIndicatorView.swift
//  JAHub
//
//  Created by Shane Whitehead on 7/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import UIKit
import PureLayout

class InfiniteWaitIndicatorView: AnimatableView {
	
	// This is deliberate, as it needs to fit with the reset of the
	// intention of the API
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 36, height: 36)
	}

	var imageView: UIImageView!

	internal var displayLink: CADisplayLink!
	
	//var rotationsPerSecond: Double = 360.0 / 1000.0
	var cycleTime: TimeInterval = 1.2 // One rotation per second
	
	var tickColor: UIColor = UIColor.black
	
	var isAnimating: Bool {
		return !displayLink.isPaused
	}
	
	internal var cycleStartTime: Date?

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}

	func commonInit() {
		configureForAutoLayout()
		// I'm now wondering if I should just generate a series of images and
		// let the imageview animate itself :/
		imageView = UIImageView(forAutoLayout: ())
		imageView.contentMode = .scaleAspectFit
		addSubview(imageView)
		
		imageView.autoPinEdgesToSuperviewEdges()

		displayLink = CADisplayLink(target: self, selector: #selector(animationDidUpdate))
		displayLink.preferredFramesPerSecond = 60
		displayLink.add(to: .current, forMode: RunLoop.Mode.common)
		displayLink.isPaused = true
	}
	
	override public func startAnimating() {
		cycleStartTime = Date()
		displayLink.isPaused = false
	}
	
	override public func stopAnimating() {
		displayLink.isPaused = true
		cycleStartTime = nil
	}
	
	@objc func animationDidUpdate(displayLink: CADisplayLink) {
		guard let cycleStartTime = cycleStartTime else {
			return
		}
		let duration = Date().timeIntervalSince(cycleStartTime)
		let progress = duration / cycleTime
		
		imageView.image = JAHubStyleKit.imageOfActivityIndicator(fillColor: tickColor, rotationProgress: CGFloat(progress))
	}

}
