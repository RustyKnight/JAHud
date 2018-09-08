//
//  ViewController.swift
//  JAHubExample
//
//  Created by Shane Whitehead on 7/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import UIKit
import JAHud

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	var progress: Progress = Progress(totalUnitCount: 100)

	@IBAction func makeItShow(_ sender: Any) {
		//Hud.presentWait(on: self, title: "All your base are belong to us", text: "So there")
		progress.completedUnitCount = 0
		var config = Hud.Configuration()
		config.progress.strokeWidth = 3.0
		config.state.fillStyle = .filled
		
//		config.titleColor = UIColor.white
//		config.textColor = UIColor.gray
//
//		config.progress.strokeColor = UIColor.magenta
//		config.waitIndicatorColor = UIColor.purple
//
//		config.state.successColor = UIColor.green
//		config.state.failColor = UIColor.orange
//
//		config.contentBackgroundColor = UIColor.blue.withAlphaComponent(0.5)
		
		Hud.presentProgress(on: self, progress: progress, title: "All your base are belong to us", text: "So there", configuration: config) {
			DispatchQueue.global(qos: .userInitiated).async {
				while self.progress.fractionCompleted < 1.0 {
					Thread.sleep(forTimeInterval: Double.random(in: 1.0...5.0))
					let amount = Int.random(in: 5...10)
					let value = min(100, self.progress.completedUnitCount + Int64(amount))
					self.progress.completedUnitCount += value
				}
				Thread.sleep(forTimeInterval: 1.0)
				DispatchQueue.main.async {
//					Hud.presentFailure(on: self) {
					Hud.presentSuccess(on: self) {
						Hud.dismiss(from: self)
					}
				}
			}
		}
	}
	
}
