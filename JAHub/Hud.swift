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
	
	struct Configuration {
		var titleColor: UIColor = UIColor.black
		var textColor: UIColor = UIColor.black
		var contentBackgroundColor: UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
		
		var progressConfiguration: ProgressConfiguration = ProgressConfiguration()
	}
	
	
	struct ProgressConfiguration {
		var strokeColor: UIColor = .black
		var strokeWidth: CGFloat = 1
		var strokeCap: CAShapeLayerLineCap = .round
	}

	
	public enum Style {
		case infiniteWait
		case progress
		case success
		case failure
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
	
	// The core content, the text surrounds this, it appears
	// in the middle and contains all the different state
	// views
	internal lazy var contentView: UIView = {
		let contentView = UIView(forAutoLayout: ())
		infiniteWaitIndicatorView.isHidden = true
		infiniteWaitIndicatorView.stopAnimating()
		
		progressIndicatorView.isHidden = true
		
		contentView.addSubview(infiniteWaitIndicatorView)
		contentView.addSubview(progressIndicatorView)
		
		print("wait = \(infiniteWaitIndicatorView.intrinsicContentSize)")
		print("progress = \(progressIndicatorView.intrinsicContentSize)")

		infiniteWaitIndicatorView.autoCenterInSuperviewMargins()
		progressIndicatorView.autoCenterInSuperviewMargins()

//		waitIndicatorView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
//		progressIndicatorView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))

		infiniteWaitIndicatorView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16, relation: .greaterThanOrEqual)
		infiniteWaitIndicatorView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16, relation: .greaterThanOrEqual)
		infiniteWaitIndicatorView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16, relation: .greaterThanOrEqual)
		infiniteWaitIndicatorView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16, relation: .greaterThanOrEqual)
		infiniteWaitIndicatorView.autoSetDimension(.width, toSize: 36.0)
		infiniteWaitIndicatorView.autoSetDimension(.height, toSize: 36.0)

		progressIndicatorView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16, relation: .greaterThanOrEqual)
		progressIndicatorView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16, relation: .greaterThanOrEqual)
		progressIndicatorView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16, relation: .greaterThanOrEqual)
		progressIndicatorView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16, relation: .greaterThanOrEqual)

		return contentView
	}()
	
	public var style: Style = .infiniteWait {
		didSet {
			// Need to know if we should animate the change or not...
			styleDidChange()
		}
	}

	internal func commonInit() {
		backgroundColor = UIColor.clear
		isOpaque = false
		blurBackground = UIVisualEffectView()
		addSubview(blurBackground)
		blurBackground.autoPinEdgesToSuperviewEdges()
	}
	
	internal func configureHud(withTitle title: String? = nil, text: String? = nil) {
		commonInit()
		
		let titleLabel = UILabel()
		titleLabel.textAlignment = .center
		titleLabel.text = title
		//titleLabel.textColor = CleanSweep.textIcons
		titleLabel.numberOfLines = 0
		
		let textLabel = UILabel()
		textLabel.textAlignment = .center
		textLabel.text = text
		//textLabel.textColor = CleanSweep.textIcons
		textLabel.numberOfLines = 0
		
		let stackView = UIStackView(arrangedSubviews: [titleLabel, contentView, textLabel])
		stackView.alignment = .center
		stackView.distribution = .equalCentering
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.configureForAutoLayout()
		
		textLabel.isHidden = text == nil
		titleLabel.isHidden = title == nil
		
		backgroundView.addSubview(stackView)
//		stackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
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
	
	// Need to know if we should animate the change or not...
	internal func styleDidChange() {
		guard let superView = superview else {
			infiniteWaitIndicatorView.isHidden = true
			infiniteWaitIndicatorView.stopAnimating()
			progressIndicatorView.isHidden = true
			progressIndicatorView.stopAnimating()
			
			switch style {
			case .progress:
				progressIndicatorView.isHidden = false
				progressIndicatorView.startAnimating()
				fallthrough
			case .infiniteWait:
				infiniteWaitIndicatorView.isHidden = false
				infiniteWaitIndicatorView.startAnimating()
			case .success: break
			case .failure: break
			}
			layoutIfNeeded()
			return
		}
	}

	// MARK: - Globle accessible functionality
	
	private static var registery: [UIView: Hud] = [:]
	
	internal static func present(style: Style, on parent: UIView,
															 title: String? = nil,
															 text: String? = nil,
															 progress: Progress? = nil) {
		guard registery[parent] == nil else {
			return
		}
		let hud = Hud()
		hud.configureHud(withTitle: title, text: text)
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
