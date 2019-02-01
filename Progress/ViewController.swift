//
//  ViewController.swift
//  Progress
//
//  Created by Joe on 1/29/19.
//  Copyright © 2019 Joe. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
	
	@IBOutlet weak var progressBar: UIProgressView!
	var timer: Timer!
	var progressCounter:Float = 0
	let duration:Float = 10.0
	var progressIncrement:Float = 0
	let labelTag: Int = 10
	let buttonTag: Int = 35
	var downloadError: NSError?
	let downloadProgress: Float = 1
	var progressIndicator: ProgressIndicator?

	override func viewDidLoad() {
		super.viewDidLoad()
		//runTimer()
		
		progressIndicator = ProgressIndicator(frame: CGRect.zero)
//		progressIndicator?.center = self.view.center
		progressIndicator?.center.x = 175
		progressIndicator?.center.y = 300
		if let progressIndicator = progressIndicator {
			self.view.addSubview(progressIndicator)
		}

	}

	func runTimer(){
		progressIncrement = 1.0/duration
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showProgress), userInfo: nil, repeats: true)
	}
	
	@objc func showProgress(){
		if (progressCounter > 1.0){timer.invalidate()}
		 progressBar.progress = progressCounter
		
		if progressCounter < downloadProgress {
			self.progressIndicator?.removeLabel()
			self.progressIndicator?.downloadInProgress(with: progressCounter)
		} else if progressCounter >= downloadProgress {
			self.progressIndicator?.removeLabel()
		}
		
		progressCounter = progressCounter + progressIncrement
		
		if progressCounter > 1.0000001 {
			let error = NSError(domain: "", code: NSBundleOnDemandResourceInvalidTagError, userInfo: nil)
			self.downloadError = error
			self.progressIndicator?.createErrorButton { [weak self] in
				guard let strongSelf = self else { return }
				strongSelf.view.backgroundColor = .gray

			}
		}
	}
	
	@IBAction func resetTimer(_ sender: Any) {
		progressCounter = 0
		runTimer()
		self.progressIndicator?.removeButton()
	}
}


