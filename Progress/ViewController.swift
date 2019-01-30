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
	var errorButton: UIButton?
	var errorLabel: UILabel?

	override func viewDidLoad() {
		super.viewDidLoad()
		//runTimer()
	}
	
	enum GoodError: LocalizedError {
		case myFailure
		var errorDescription: String? {
			switch self {
			case .myFailure: return "GoodErrorMyFailure"
			}
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
			self.removeLabel()
			self.downloadInProgress(with: progressCounter)
		} else if progressCounter >= downloadProgress {
			self.removeLabel()
		}
		
		progressCounter = progressCounter + progressIncrement
		
		if progressCounter > 1.0000001 {
			let error = NSError(domain: "", code: NSBundleOnDemandResourceInvalidTagError, userInfo: nil)
			self.downloadError = error
			self.createErrorButton()
		}
	}
	
	@IBAction func resetTimer(_ sender: Any) {
		progressCounter = 0
		runTimer()
		self.removeButton()
	}
	
	

}

