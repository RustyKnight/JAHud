//
//  WaitIndicator.swift
//  JAHud
//
//  Created by Shane Whitehead on 8/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import Foundation

// I'd make it a protocol, but I need some of the view's properties and
// I can't be bothered fighting the compiler at this time
public class AnimatableView: UIView {
	public func startAnimating() {}
	public func stopAnimating() {}
}
