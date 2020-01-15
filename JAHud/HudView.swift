//
//  Hud.swift
//  CleanSweep
//
//  Created by Shane Whitehead on 1/9/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

public class HudView: UIView {
	
	@IBOutlet weak var blurBackground: UIVisualEffectView!
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var textLabel: UILabel!
	
	@IBOutlet weak var successImageView: UIImageView!
	@IBOutlet weak var failImageView: UIImageView!
	@IBOutlet weak var progressView: ProgressIndicatorView!
	@IBOutlet weak var infiniteWaitView: InfiniteWaitIndicatorView!
	@IBOutlet weak var materialWaitView: MaterialWaitIndicatorView!
	@IBOutlet weak var contentView: UIView!
	
	// This is the "system wide" configuration used by default when no
	// other configuration is otherwise specified
	public static var defaultConfiguration: Hud.Configuration = Hud.configuration
	
	internal var configuration: Hud.Configuration? {
		didSet {
			configurationDidChange()
		}
	}
	
	// Helper to make it easier to determine which configuration to use
	internal var activeConfiguration: Hud.Configuration {
		guard let config = configuration else {
			return HudView.defaultConfiguration
		}
		return config
	}
	
	public private(set) var style: Hud.Style = .infiniteWait
	
	public func set(_ style: Hud.Style, then: Hud.HudThen? = nil) {
		guard self.style != style else {
			then?()
			return
		}
		self.style = style
		styleDidChange(then: then)
	}
	
	public var title: String? {
		didSet {
			titleLabel.text = title
			titleLabel.isHidden = title == nil || title?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0
			layoutIfNeeded()
		}
	}
	
	public var text: String? {
		didSet {
			textLabel.text = text
			textLabel.isHidden = text == nil || text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0
			layoutIfNeeded()
		}
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	public init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
	}
	
//	// Base background of the overall view
//	internal var blurBackground: UIVisualEffectView!
//
//	// Background of the hub, with rounded corners
//	internal lazy var backgroundView: UIView = {
//		let backgroundView = UIView(forAutoLayout: ())
//		backgroundView.backgroundColor = activeConfiguration.contentBackgroundColor
//		backgroundView.layer.cornerRadius = 20
//		backgroundView.alpha = 0.75
//		return backgroundView
//	}()
//
//	// The default infinite wait indicator
//	internal lazy var tickWaitIndicatorView: InfiniteWaitIndicatorView = {
//		return InfiniteWaitIndicatorView()
//	}()
//
//	internal lazy var materialWaitIndicatorView: MaterialWaitIndicatorView = {
//		let indicator = MaterialWaitIndicatorView()
//		indicator.strokeWidth = 2.0
//		return indicator
//	}()
//
//	// The progress indicator
//	internal lazy var progressIndicatorView: ProgressIndicatorView = {
//		return ProgressIndicatorView()
//	}()
//
//	// The success view
//	internal lazy var successView: UIImageView = {
//		let view = UIImageView(image: successImage)
//		view.contentMode = .scaleAspectFit
//		return view
//	}()
//
//	// The fail view
//	internal lazy var failView: UIImageView = {
//		let view = UIImageView(image: failImage)
//		view.contentMode = .scaleAspectFit
//		return view
//	}()
//
	internal var successImage: UIImage {
		switch activeConfiguration.state.fillStyle {
		case .outlined: return JAHubStyleKit.imageOfSuccessOutlined(fillColor: activeConfiguration.state.successColor)
		case .filled: return JAHubStyleKit.imageOfSuccessFilled(fillColor: activeConfiguration.state.successColor)
		}
	}
	
	internal var failImage: UIImage {
		switch activeConfiguration.state.fillStyle {
		case .outlined: return JAHubStyleKit.imageOfFailOutlined(fillColor: activeConfiguration.state.failColor)
		case .filled: return JAHubStyleKit.imageOfFailFilled(fillColor: activeConfiguration.state.failColor)
		}
	}
	
	// The core content, the text surrounds this, it appears
	// in the middle and contains all the different state
	// views
//	internal lazy var contentView: UIView = {
//		let contentView = UIView(forAutoLayout: ())
//		tickWaitIndicatorView.stopAnimating()
//		materialWaitIndicatorView.stopAnimating()
//
//		for view in [progressIndicatorView, failView, successView] {
//			view.isHidden = false
//			view.configureForAutoLayout()
//			contentView.addSubview(view)
//
//			view.autoPinEdgesToSuperviewEdges()
//		}
//
//		tickWaitIndicatorView.configureForAutoLayout()
//		contentView.addSubview(tickWaitIndicatorView)
//		tickWaitIndicatorView.autoCenterInSuperview()
//		tickWaitIndicatorView.autoSetDimension(.width, toSize: 36.0)
//		tickWaitIndicatorView.autoSetDimension(.height, toSize: 36.0)
//
//		materialWaitIndicatorView.configureForAutoLayout()
//		contentView.addSubview(materialWaitIndicatorView)
//		materialWaitIndicatorView.autoCenterInSuperview()
//		materialWaitIndicatorView.autoSetDimension(.width, toSize: 36.0)
//		materialWaitIndicatorView.autoSetDimension(.height, toSize: 36.0)
//
//		return contentView
//	}()
//
//	internal static let defaultContentSize: CGFloat = 50
//
//	internal lazy var titleLabel: UILabel = {
//		let label = UILabel()
//		label.textAlignment = .center
//		label.numberOfLines = 0
//		return label
//	}()
//
//	internal lazy var textLabel: UILabel = {
//		let label = UILabel()
//		label.textAlignment = .center
//		label.numberOfLines = 0
//		return label
//	}()
//
//	internal func commonInit() {
//		backgroundColor = UIColor.clear
//		isOpaque = false
//
//		let effect = UIBlurEffect(style: .regular)
//		blurBackground = UIVisualEffectView(effect: effect)
//		addSubview(blurBackground)
//		blurBackground.autoPinEdgesToSuperviewEdges()
//
//		let stackView = UIStackView(arrangedSubviews: [titleLabel, contentView, textLabel])
//		stackView.alignment = .center
//		stackView.distribution = .equalCentering
//		stackView.axis = .vertical
//		stackView.spacing = 8
//		stackView.configureForAutoLayout()
//
//		contentViewWidthConstraint = contentView.autoSetDimension(.width, toSize: HudView.defaultContentSize)
//		contentViewHeightConstraint = contentView.autoSetDimension(.height, toSize: HudView.defaultContentSize)
//
//		backgroundView.addSubview(stackView)
//
////		stackView.autoCenterInSuperviewMargins()
//
//		stackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
//		stackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
//		stackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16)
//		stackView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16)
//
//		blurBackground.contentView.addSubview(backgroundView)
//		backgroundView.autoCenterInSuperview()
//
//		backgroundView.autoSetDimension(.width, toSize: 250, relation: .lessThanOrEqual)
//
//		// This might need to change for iPads :/
////		backgroundView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 100, relation: .greaterThanOrEqual)
////		backgroundView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 100, relation: .greaterThanOrEqual)
//	}
//
//	internal var contentViewWidthConstraint: NSLayoutConstraint!
//	internal var contentViewHeightConstraint: NSLayoutConstraint!
	
	func applyBlur() {
		let config = activeConfiguration
		switch config.mode {
		case .light:
			blurBackground.effect = UIBlurEffect(style: .light)
		case .dark:
			blurBackground.effect = UIBlurEffect(style: .dark)
		}
	}

	internal func configurationDidChange() {
		let config = activeConfiguration

		contentView.backgroundColor = activeConfiguration.contentBackgroundColor
		contentView.layer.cornerRadius = 20
		contentView.alpha = 0.75

		switch config.mode {
		case .light:
			blurBackground.effect = UIBlurEffect(style: .light)
		case .dark:
			blurBackground.effect = UIBlurEffect(style: .dark)
		}
		
//		contentViewWidthConstraint.constant = HudView.defaultContentSize + config.progress.strokeWidth
//		contentViewHeightConstraint.constant = HudView.defaultContentSize + config.progress.strokeWidth
		
		successImageView.image = successImage
		failImageView.image = failImage
		
		titleLabel.textColor = config.titleColor
		textLabel.textColor = config.textColor
		
		infiniteWaitView.tickColor = config.waitIndicatorColor
		materialWaitView.strokeColor = config.waitIndicatorColor
		
		progressView.strokeColor = config.progress.strokeColor
		progressView.strokeCap = config.progress.strokeCap
		progressView.strokeWidth = config.progress.strokeWidth

		progressView.trackColor = config.progress.trackColor
		progressView.trackWidth = config.progress.trackWidth

		layoutIfNeeded()
	}
	
	var activeWaitIndicator: AnimatableView {
		switch activeConfiguration.waitIndicatorStyle {
		case .iOS: return infiniteWaitView
		case .material: return materialWaitView
		}
	}
	
	var inactiveWaitIndicator: AnimatableView {
		switch activeConfiguration.waitIndicatorStyle {
		case .iOS: return materialWaitView
		case .material: return infiniteWaitView
		}
	}
	
	// Need to know if we should animate the change or not...
	internal func styleDidChange(then: Hud.HudThen? = nil) {
		guard superview != nil else {
			infiniteWaitView.isHidden = true
			infiniteWaitView.stopAnimating()
			
			materialWaitView.isHidden = true
			materialWaitView.stopAnimating()

			progressView.isHidden = true
			progressView.stopAnimating()
			
			successImageView.isHidden = true
			failImageView.isHidden = true
			
			switch style {
			case .progress:
				progressView.isHidden = false
				progressView.startAnimating()
				fallthrough
			case .infiniteWait:
				activeWaitIndicator.startAnimating()
				activeWaitIndicator.isHidden = false
			case .success: successImageView.isHidden = false
			case .failure: failImageView.isHidden = false
			}
			layoutIfNeeded()
			then?()
			return
		}
		
		let views = [activeWaitIndicator, inactiveWaitIndicator, progressView, successImageView, failImageView, titleLabel, textLabel]
		var incoming: [UIView] = []
		
		if title != nil {
			incoming.append(titleLabel)
		}
		if text != nil {
			incoming.append(textLabel)
		}
		
		switch style {
		case .progress:
			if progressView.isHidden {
				incoming.append(progressView)
			}
			fallthrough
		case .infiniteWait:
			if activeWaitIndicator.isHidden {
				incoming.append(activeWaitIndicator)
			}
		case .success:
			if successImageView.isHidden {
				incoming.append(successImageView)
			}
		case .failure:
			if failImageView.isHidden {
				incoming.append(failImageView)
			}
		}
		
		if style == .progress {
			progressView.startAnimating()
			progressView.startAnimating()
		} else if style == .infiniteWait {
			activeWaitIndicator.startAnimating()
		}
		
		let outgoing = views.filter { (view) -> Bool in
			!view!.isHidden && !incoming.contains(view!)
		}
		
		for view in incoming {
			view.alpha = 0.0
			view.transform = CGAffineTransform(scaleX: 0, y: 0)
			view.isHidden = false
		}
		
		UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
			for view in incoming {
				view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				view.alpha = 1.0
			}
			for view in outgoing {
				view!.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
				view!.alpha = 0.0
			}
			self.layoutIfNeeded()
		}) { completed in
			for view in outgoing {
				view!.isHidden = true
				// Just in case we need these later :/
				view!.alpha = 1.0
				view!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			}
			self.inactiveWaitIndicator.stopAnimating()
			if self.style == .success || self.style == .failure {
				self.progressView.stopAnimating()
			}
			then?()
		}
	}

	
}
