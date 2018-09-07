//
//  ViewController.swift
//  JAHubExample
//
//  Created by Shane Whitehead on 7/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import UIKit
import JAHub

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	var progress: Progress = Progress(totalUnitCount: 100)

	@IBAction func makeItShow(_ sender: Any) {
		//Hud.presentWait(on: self, title: "All your base are belong to us", text: "So there")
		Hud.presentProgress(on: self, progress: progress, title: "All your base are belong to us", text: "So there")
		
		DispatchQueue.global(qos: .userInitiated).async {
			while self.progress.fractionCompleted < 1.0 {
				Thread.sleep(forTimeInterval: Double.random(in: 1.0...5.0))
				let amount = Int.random(in: 1...10)
				let value = min(100, self.progress.completedUnitCount + Int64(amount))
				self.progress.completedUnitCount += value
			}
			
			Thread.sleep(forTimeInterval: 1.0)
			
			DispatchQueue.main.async {
				Hud.dismiss(from: self)
			}
		}
	}
	
}

