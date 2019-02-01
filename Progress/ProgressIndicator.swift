//
//  ProgressIndicator.swift
//  Progress
//
//  Created by Joe on 1/29/19.
//  Copyright © 2019 Joe. All rights reserved.
//

import Foundation
import UIKit

class ProgressIndicator: UIView {
	
	typealias VoidClosure = () -> Void
	var retryBlock: (VoidClosure)?
	var errorButton = UIButton()
	var downloadLabel = UILabel()
	var downloadError: Error?
	override var intrinsicContentSize: CGSize {
		//preferred content size, calculate it if some internal state changes
		return CGSize(width: 300, height: 300)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)

	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	
	func downloadInProgress(with percent: Float){
		let downloadProgress = Int(percent * 100)
		downloadLabel.cgzie
//		let labelFrame = CGRect(x: 0, y: 0, width: 200, height: 21)
//		downloadLabel = UILabel(frame: labelFrame)
////		downloadLabel.center = self.center
//		downloadLabel.center.x = 175
//		downloadLabel.center.y = 300
		downloadLabel.text = "Download Progress: \(downloadProgress)%"

		self.addSubview(downloadLabel)

	}

	func removeLabel(){
		downloadLabel.removeFromSuperview()
	}
	
	func removeButton(){
		errorButton.removeFromSuperview()
	}
	
	func downloadComplete(){
	}
	
	
	func createErrorButton(retryBlock: @escaping VoidClosure) {
		let buttonFrame = CGRect(x: 0, y: 0, width: 150, height: 25)
		let myButton = UIButton(type: .system)
		myButton.frame = buttonFrame
		myButton.setTitle("Error Downloading", for: .normal)
		myButton.center.x = self.center.x
		myButton.center.y = 300
		myButton.addTarget(self, action: #selector(self.showErrorAlert), for: .touchUpInside)
		errorButton = myButton

		self.addSubview(errorButton)

	}
	
	
	@objc func showErrorAlert(){
		self.removeButton()
		guard let retryRequest = self.retryBlock else { assertionFailure("ErrorButton is nil"); return }
		if let error = downloadError {
			let controller = UIAlertController(
				title: "Error",
				message: error.localizedDescription,
				preferredStyle: .alert)
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
			
			let retryAction = UIAlertAction(
				title: "Retry",
				style: .default) { _ in
					
				return retryRequest()
			}
			
			controller.addAction(retryAction)
			controller.addAction(cancelAction)
			UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
		}
	}
}


