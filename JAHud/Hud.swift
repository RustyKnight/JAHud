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

public class Hud: UIView {
	
	public struct Configuration {
		public var titleColor: UIColor = UIColor.black
		public var textColor: UIColor = UIColor.black
		
		public var waitIndicatorColor: UIColor = UIColor.black
		
		public var contentBackgroundColor: UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
		
		public var progress: ProgressConfiguration = ProgressConfiguration()

		// Fail and success states
		public var state: StateConfiguration = StateConfiguration()
		
		public init() {}
	}
	
	public struct ProgressConfiguration {
		public var strokeColor: UIColor = .black
		public var strokeWidth: CGFloat = 1
		public var strokeCap: CAShapeLayerLineCap = .round
		
		public init() {}
	}
	
	public enum FillStyle {
		case outlined
		case filled
	}
	
	public struct StateConfiguration {
		public var successColor: UIColor = .black
		public var failColor: UIColor = .black
		public var fillStyle: FillStyle = .outlined
	}
	
	public enum Style {
		case infiniteWait
		case progress
		case success
		case failure
	}
	
	// This is the "system wide" configuration used by default when no
	// other configuration is otherwise specified
	public static var defaultConfiguration: Configuration = Configuration()
	
	internal var configuration: Configuration? {
		didSet {
			configurationDidChange()
		}
	}
	
	// Helper to make it easier to determine which configuration to use
	internal var activeConfiguration: Configuration {
		guard let config = configuration else {
			return Hud.defaultConfiguration
		}
		return config
	}
	
	public typealias HudThen = () -> Void
	
	public private(set) var style: Style = .infiniteWait
	
	public func set(_ style: Style, then: HudThen? = nil) {
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
		configureForAutoLayout()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configureForAutoLayout()
	}
	
	public init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		commonInit()
	}
	
	// Base background of the overall view
	internal var blurBackground: UIVisualEffectView!
	
	// Background of the hub, with rounded corners
	internal lazy var backgroundView: UIView = {
		let backgroundView = UIView(forAutoLayout: ())
		backgroundView.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.75)
		backgroundView.layer.cornerRadius = 20
		backgroundView.alpha = 0.75
		return backgroundView
	}()
	
	// The default infinite wait indicator
	internal lazy var infiniteWaitIndicatorView: InfiniteWaitIndicatorView = {
		return InfiniteWaitIndicatorView()
	}()
	
	// The progress indicator
	internal lazy var progressIndicatorView: ProgressIndicatorView = {
		return ProgressIndicatorView()
	}()
	
	// The success view
	internal lazy var successView: UIImageView = {
		let view = UIImageView(image: successImage)
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	// The fail view
	internal lazy var failView: UIImageView = {
		let view = UIImageView(image: failImage)
		view.contentMode = .scaleAspectFit
		return view
	}()
	
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
	internal lazy var contentView: UIView = {
		let contentView = UIView(forAutoLayout: ())
		infiniteWaitIndicatorView.stopAnimating()
		
		for view in [progressIndicatorView, failView, successView] {
			view.isHidden = false
			view.configureForAutoLayout()
			contentView.addSubview(view)
			
			view.autoPinEdgesToSuperviewEdges()
		}
		
		infiniteWaitIndicatorView.configureForAutoLayout()
		contentView.addSubview(infiniteWaitIndicatorView)
		infiniteWaitIndicatorView.autoCenterInSuperview()
		infiniteWaitIndicatorView.autoSetDimension(.width, toSize: 36.0)
		infiniteWaitIndicatorView.autoSetDimension(.height, toSize: 36.0)
		
		return contentView
	}()
	
	internal static let defaultContentSize: CGFloat = 50
	
	internal lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	internal lazy var textLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	internal func commonInit() {
		backgroundColor = UIColor.clear
		isOpaque = false
		blurBackground = UIVisualEffectView()
		addSubview(blurBackground)
		blurBackground.autoPinEdgesToSuperviewEdges()
		
		let stackView = UIStackView(arrangedSubviews: [titleLabel, contentView, textLabel])
		stackView.alignment = .center
		stackView.distribution = .equalCentering
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.configureForAutoLayout()
		
		contentViewWidthConstraint = contentView.autoSetDimension(.width, toSize: Hud.defaultContentSize)
		contentViewHeightConstraint = contentView.autoSetDimension(.height, toSize: Hud.defaultContentSize)

		backgroundView.addSubview(stackView)
		
//		stackView.autoCenterInSuperviewMargins()
		
		stackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
		stackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
		stackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16)
		stackView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16)

		blurBackground.contentView.addSubview(backgroundView)
		backgroundView.autoCenterInSuperview()
		
		backgroundView.autoSetDimension(.width, toSize: 250, relation: .lessThanOrEqual)

		// This might need to change for iPads :/
//		backgroundView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 100, relation: .greaterThanOrEqual)
//		backgroundView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 100, relation: .greaterThanOrEqual)
	}
	
	internal var contentViewWidthConstraint: NSLayoutConstraint!
	internal var contentViewHeightConstraint: NSLayoutConstraint!

	internal func configurationDidChange() {
		
		let config = activeConfiguration
		
		backgroundView.backgroundColor = config.contentBackgroundColor
		
		contentViewWidthConstraint.constant = Hud.defaultContentSize + config.progress.strokeWidth
		contentViewHeightConstraint.constant = Hud.defaultContentSize + config.progress.strokeWidth
		
		successView.image = successImage
		failView.image = failImage
		
		titleLabel.textColor = config.titleColor
		textLabel.textColor = config.textColor
		
		infiniteWaitIndicatorView.tickColor = config.waitIndicatorColor
		
		progressIndicatorView.strokeColor = config.progress.strokeColor
		progressIndicatorView.strokeCap = config.progress.strokeCap
		progressIndicatorView.strokeWidth = config.progress.strokeWidth
		
		layoutIfNeeded()
	}
	
	// Need to know if we should animate the change or not...
	internal func styleDidChange(then: HudThen? = nil) {
		guard superview != nil else {
			infiniteWaitIndicatorView.isHidden = true
			infiniteWaitIndicatorView.stopAnimating()
			progressIndicatorView.isHidden = true
			progressIndicatorView.stopAnimating()
			
			successView.isHidden = true
			failView.isHidden = true
			
			switch style {
			case .progress:
				progressIndicatorView.isHidden = false
				progressIndicatorView.startAnimating()
				fallthrough
			case .infiniteWait:
				infiniteWaitIndicatorView.isHidden = false
				infiniteWaitIndicatorView.startAnimating()
			case .success: successView.isHidden = false
			case .failure: failView.isHidden = false
			}
			layoutIfNeeded()
			then?()
			return
		}
		
		let views = [infiniteWaitIndicatorView, progressIndicatorView, successView, failView]
		var incoming: [UIView] = []
		switch style {
		case .progress:
			if progressIndicatorView.isHidden {
				incoming.append(progressIndicatorView)
			}
			fallthrough
		case .infiniteWait:
			if infiniteWaitIndicatorView.isHidden {
				incoming.append(infiniteWaitIndicatorView)
			}
		case .success:
			if successView.isHidden {
				incoming.append(successView)
			}
		case .failure:
			if failView.isHidden {
				incoming.append(failView)
			}
		}
		
		if style == .progress {
			progressIndicatorView.startAnimating()
			infiniteWaitIndicatorView.startAnimating()
		} else if style == .infiniteWait {
			infiniteWaitIndicatorView.startAnimating()
		}
		
		let outgoing = views.filter { (view) -> Bool in
			!view.isHidden && !incoming.contains(view)
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
				view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
				view.alpha = 0.0
			}
			self.layoutIfNeeded()
		}) { completed in
			for view in outgoing {
				view.isHidden = true
				// Just in case we need these later :/
				view.alpha = 1.0
				view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			}
			if self.style == .success || self.style == .failure {
				self.progressIndicatorView.stopAnimating()
				self.infiniteWaitIndicatorView.stopAnimating()
			}
			then?()
		}
	}
	
	// MARK: - Globle accessible functionality
	
	private static var registery: [UIView: Hud] = [:]
	
	internal static func present(style: Style,
															 on parent: UIView,
															 title: String? = nil,
															 text: String? = nil,
															 progress: Progress? = nil,
															 configuration: Configuration? = nil,
															 then: HudThen? = nil) {
		
		if let hud = registery[parent] {
			if title != nil && (hud.title == nil || hud.title != title) {
				hud.title = title
			}
			if text != nil && (hud.text == nil || hud.text != text) {
				hud.text = text
			}
			
			if hud.configuration == nil && configuration != nil {
				hud.configuration = configuration
			}
			
			hud.set(style, then: then)
			return
		}
		
		let hud = Hud()
		hud.configuration = configuration
		hud.title = title
		hud.text = text
		hud.alpha = 0
		hud.backgroundView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
		hud.set(style)
		hud.progressIndicatorView.progress = progress
		
		registery[parent] = hud
		
		parent.addSubview(hud)
		hud.autoPinEdgesToSuperviewEdges()
		
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
			hud.backgroundView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			hud.alpha = 1.0
			hud.blurBackground.effect = UIBlurEffect(style: .light)
		}) { completed in
			then?()
		}
	}
	
	// MARK: - Present infinite wait
	
	public static func presentWait(on parent: UIViewController, title: String? = nil, text: String? = nil,
																 configuration: Configuration? = nil, then: HudThen? = nil) {
		presentWait(on: parent.view, title: title, text: text, configuration: configuration, then: then)
	}
	
	public static func presentWait(on parent: UIView, title: String? = nil, text: String? = nil,
																 configuration: Configuration? = nil, then: HudThen? = nil) {
		present(style: .infiniteWait, on: parent, title: title, text: text, configuration: configuration, then: then)
	}
	
	// MARK: - Present progress
	
	public static func presentProgress(on controller: UIViewController, progress: Progress, title: String? = nil, text: String? = nil,
																		 configuration: Configuration? = nil, then: HudThen? = nil) {
		presentProgress(on: controller.view, progress: progress, title: title, text: text, configuration: configuration, then: then)
	}
	
	public static func presentProgress(on view: UIView, progress: Progress, title: String? = nil, text: String? = nil,
																		 configuration: Configuration? = nil, then: HudThen? = nil) {
		present(style: .progress, on: view, title: title, text: text, progress: progress, configuration: configuration, then: then)
	}
	
	// MARK: - Present success
	
	public static func presentSuccess(on controller: UIViewController, title: String? = nil, text: String? = nil,
																		configuration: Configuration? = nil, then: HudThen? = nil) {
		presentSuccess(on: controller.view, title: title, text: text, configuration: configuration, then: then)
	}
	
	public static func presentSuccess(on view: UIView, title: String? = nil, text: String? = nil,
																		configuration: Configuration? = nil, then: HudThen? = nil) {
		present(style: .success, on: view, title: title, text: text, configuration: configuration, then: then)
	}
	
	// MARK: - Present success
	
	public static func presentFailure(on controller: UIViewController, title: String? = nil, text: String? = nil,
																	 configuration: Configuration? = nil, then: HudThen? = nil) {
		presentFailure(on: controller.view, title: title, text: text, configuration: configuration, then: then)
	}
	
	public static func presentFailure(on view: UIView, title: String? = nil, text: String? = nil,
																	 configuration: Configuration? = nil, then: HudThen? = nil) {
		present(style: .failure, on: view, title: title, text: text, configuration: configuration, then: then)
	}
	
	// MARK: - Dismiss
	
	public static func dismiss(from parent: UIViewController, then: HudThen? = nil) {
		dismiss(from: parent.view, then: then)
	}
	
	public static func dismiss(from parent: UIView, then: HudThen? = nil) {
		guard let hud = registery[parent] else {
			then?()
			return
		}
		hud.layer.removeAllAnimations()
		UIView.animate(withDuration: 0.3, animations: {
			hud.backgroundView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			hud.alpha = 0.0
		}) { (completed) in
			hud.removeFromSuperview()
			registery[parent] = nil
			then?()
		}
	}
	
	
}
