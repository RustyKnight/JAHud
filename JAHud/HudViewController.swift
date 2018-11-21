//
//  HudViewController.swift
//  JAHud
//
//  Created by Shane Whitehead on 8/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import UIKit
import PureLayout

public class HudViewController: UIViewController {

//	public private(set) lazy var hudView: HudView = {
//		return HudView()
//	}()
	
	public private(set) lazy var hudView: HudView = {
		let bundle = Bundle(for: HudView.self)
		guard let view = bundle.loadNibNamed("HudView", owner: self, options: nil)?.first as? HudView else {
			fatalError("Could not load requied sub hud view")
		}
		return view
	}()
	
	var afterAppear: Hud.HudThen?
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.clear
		view.isOpaque = false
		
		view.addSubview(hudView)
		
		hudView.autoPinEdgesToSuperviewEdges()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		hudView.alpha = 0
		hudView.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.hudView.blurBackground.effect = nil
		UIView.animate(withDuration: 0.3,
									 delay: 0,
									 usingSpringWithDamping: 0.5,
									 initialSpringVelocity: 0,
									 options: .curveEaseInOut,
									 animations: {
			self.hudView.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			self.hudView.alpha = 1.0
			self.hudView.applyBlur()
		}) { completed in
			self.afterAppear?()
		}
	}
	
	public override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
		hudView.layer.removeAllAnimations()
		UIView.animate(withDuration: 0.3, animations: {
			self.hudView.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			self.hudView.alpha = 0.0
		}) { (completed) in
			super.dismiss(animated: animated, completion: completion)
		}
	}
	
	public override var preferredStatusBarStyle: UIStatusBarStyle {
		switch hudView.configuration?.mode ?? .light {
		case .light: return UIStatusBarStyle.default
		case .dark: return UIStatusBarStyle.lightContent
		}
	}
	
}
