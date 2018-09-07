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
		var titleColor: UIColor = UIColor.black
		var textColor: UIColor = UIColor.black
		var contentBackgroundColor: UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
		
		var progress: ProgressConfiguration = ProgressConfiguration()
		
		var success: StateConfiguration = StateConfiguration()
		var fail: StateConfiguration = StateConfiguration()
	}
	
	public struct ProgressConfiguration {
		var strokeColor: UIColor = .black
		var strokeWidth: CGFloat = 1
		var strokeCap: CAShapeLayerLineCap = .round
	}
	
	public enum FillStyle {
		case outlined
		case filled
	}
	
	public struct StateConfiguration {
		var color: UIColor = .black
		var fillStyle: FillStyle = .outlined
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
			updateStateImages()
		}
	}
	// Helper to make it easier to determine which configuration to use
	internal var activeConfiguration: Configuration {
		guard let config = configuration else {
			return Hud.defaultConfiguration
		}
		return config
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
	
	internal lazy var progressIndicatorView: ProgressIndicatorView = {
		return ProgressIndicatorView()
	}()
	
	internal lazy var successView: UIImageView = {
		let view = UIImageView(image: successImage)
		view.contentMode = .scaleAspectFit
		return view
	}()

	internal lazy var failView: UIImageView = {
		let view = UIImageView(image: failImage)
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	internal var successImage: UIImage {
		switch activeConfiguration.success.fillStyle {
		case .outlined: return JAHubStyleKit.imageOfSuccessOutlined(fillColor: activeConfiguration.success.color)
		case .filled: return JAHubStyleKit.imageOfSuccessFilled(fillColor: activeConfiguration.success.color)
		}
	}
	
	internal var failImage: UIImage {
		switch activeConfiguration.success.fillStyle {
		case .outlined: return JAHubStyleKit.imageOfFailOutlined(fillColor: activeConfiguration.success.color)
		case .filled: return JAHubStyleKit.imageOfFailFilled(fillColor: activeConfiguration.success.color)
		}
	}

	// The core content, the text surrounds this, it appears
	// in the middle and contains all the different state
	// views
	internal lazy var contentView: UIView = {
		print("ContentView")
		let contentView = UIView(forAutoLayout: ())
		infiniteWaitIndicatorView.stopAnimating()
		
		for view in [progressIndicatorView, failView, successView] {
			view.isHidden = false
			view.configureForAutoLayout()
			contentView.addSubview(view)
			
			view.autoSetDimension(.width, toSize: 40)
			view.autoSetDimension(.height, toSize: 40)
			view.autoPinEdgesToSuperviewEdges()
		}
		
		infiniteWaitIndicatorView.configureForAutoLayout()
		contentView.addSubview(infiniteWaitIndicatorView)
		infiniteWaitIndicatorView.autoCenterInSuperview()
		infiniteWaitIndicatorView.autoSetDimension(.width, toSize: 36.0)
		infiniteWaitIndicatorView.autoSetDimension(.height, toSize: 36.0)

		return contentView
	}()
	
	public var style: Style = .infiniteWait {
		didSet {
			// Need to know if we should animate the change or not...
			styleDidChange()
		}
	}
	
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

//		contentView.autoSetDimension(.width, toSize: 40.0)
//		contentView.autoSetDimension(.height, toSize: 40.0)
		
		backgroundView.addSubview(stackView)

		stackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16, relation: .greaterThanOrEqual)
		stackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16, relation: .greaterThanOrEqual)
		stackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16, relation: .greaterThanOrEqual)
		stackView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16, relation: .greaterThanOrEqual)

		blurBackground.contentView.addSubview(backgroundView)
		backgroundView.autoCenterInSuperview()
		
		// This might need to change for iPads :/
//		backgroundView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 50.0, relation: .greaterThanOrEqual)
//		backgroundView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 50.0, relation: .greaterThanOrEqual)
	}
	
	internal func updateStateImages() {
		successView.image = successImage
		failView.image = failImage
	}
	
	// Need to know if we should animate the change or not...
	internal func styleDidChange() {
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
			return
		}
		
		print("Update style with fashion")
		
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
		}
		
		print("Incoming = \(incoming)")
		print("outgoing = \(outgoing)")

		UIView.animate(withDuration: 5.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
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
			print("Completed = \(completed)")
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
		}
	}

	// MARK: - Globle accessible functionality
	
	private static var registery: [UIView: Hud] = [:]
	
	internal static func present(style: Style,
															 on parent: UIView,
															 title: String? = nil,
															 text: String? = nil,
															 progress: Progress? = nil) {
		print("Parent = \(parent)")
		print("registery = \(registery[parent])")
		if let hud = registery[parent] {
			print("Update only")
			hud.style = style
			
			if title != nil && (hud.title == nil || hud.title != title) {
				hud.title = title
			}
			if text != nil && (hud.text == nil || hud.text != text) {
				hud.text = text
			}
			return
		}
		
		let hud = Hud()
		hud.title = title
		hud.text = text
		hud.alpha = 0
		hud.backgroundView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
		hud.style = style
		hud.progressIndicatorView.progress = progress
		
		registery[parent] = hud
		
		parent.addSubview(hud)
		hud.autoPinEdgesToSuperviewEdges()
		
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
			hud.backgroundView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			hud.alpha = 1.0
			hud.blurBackground.effect = UIBlurEffect(style: .light)
		}, completion: nil)
	}
	
	// MARK: - Present infinite wait

	public static func presentWait(on parent: UIViewController, title: String? = nil, text: String? = nil) {
		presentWait(on: parent.view, title: title, text: text)
	}

	public static func presentWait(on parent: UIView, title: String? = nil, text: String? = nil) {
		present(style: .infiniteWait, on: parent, title: title, text: text)
	}

	// MARK: - Present progress

	public static func presentProgress(on controller: UIViewController, progress: Progress, title: String? = nil, text: String? = nil) {
		presentProgress(on: controller.view, progress: progress, title: title, text: text)
	}

	public static func presentProgress(on view: UIView, progress: Progress, title: String? = nil, text: String? = nil) {
		present(style: .progress, on: view, title: title, text: text, progress: progress)
	}

	// MARK: - Present success
	
	public static func presentSuccess(on controller: UIViewController, title: String? = nil, text: String? = nil) {
		presentSuccess(on: controller.view, title: title, text: text)
	}
	
	public static func presentSuccess(on view: UIView, title: String? = nil, text: String? = nil) {
		present(style: .success, on: view, title: title, text: text)
	}
	
	// MARK: - Dismiss

	public typealias HudDismissed = () -> Void
	
	public static func dismiss(from parent: UIViewController, then: HudDismissed? = nil) {
		dismiss(from: parent.view, then: then)
	}
	
	public static func dismiss(from parent: UIView, then: HudDismissed? = nil) {
		guard let hud = registery[parent] else {
			return
		}
		hud.layer.removeAllAnimations()
		UIView.animate(withDuration: 0.3, animations: {
			hud.backgroundView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			hud.alpha = 0.0
		}) { (completed) in
			hud.removeFromSuperview()
			registery[parent] = nil
		}
	}


}
