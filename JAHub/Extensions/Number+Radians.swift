//
//  Number+Radians.swift
//  JAHub
//
//  Created by Shane Whitehead on 7/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import Foundation
extension BinaryInteger {
	var toRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
	var toDegrees: CGFloat { return CGFloat(Int(self)) * 180 / .pi }
}

extension FloatingPoint {
	var toRadians: Self { return self * .pi / 180 }
	var toDegrees: Self { return self * 180 / .pi }
}
