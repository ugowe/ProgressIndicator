//
//  ProgressIndicator.swift
//  Progress
//
//  Created by Joe on 1/29/19.
//  Copyright © 2019 Joe. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
	
	typealias VoidClosure = () -> Void
	
	func downloadInProgress(with percent: Float){
		let downloadProgress = Int(percent * 100)
		let labelFrame = CGRect(x: 0, y: 0, width: 200, height: 21)
		let label = UILabel(frame: labelFrame)
		label.center = self.view.center
		label.text = "Download Progress: \(downloadProgress)%"
		errorLabel = label
		if let errorLabel = errorLabel {
		self.view.addSubview(errorLabel)
		}
	}
	
	func removeLabel(){
		if let errorLabel = errorLabel {
			errorLabel.removeFromSuperview()
		}
	}
	
	func removeButton(){
		if let errorButton = errorButton {
			errorButton.removeFromSuperview()
		}
	}

	
	func downloadComplete(){
	}
	
	func presentErrorScreens(retryBlock: VoidClosure){
		createErrorButton()
		
	}
	
	func createErrorButton() {
		let buttonFrame = CGRect(x: 0, y: 0, width: 150, height: 25)
		let myButton = UIButton(type: .system)
		myButton.tag = buttonTag
		myButton.frame = buttonFrame
		myButton.setTitle("Error Downloading", for: .normal)
		myButton.center.x = self.view.center.x
		myButton.center.y = 300
		myButton.addTarget(self, action: #selector(self.showErrorAlert), for: .touchUpInside)
		errorButton = myButton
		if let errorButton = errorButton {
			self.view.addSubview(errorButton)
		}
	}
	

	@objc func showErrorAlert(){
		self.removeButton()
		if let error = downloadError {
			let controller = UIAlertController(
				title: "Error",
				message: error.localizedDescription,
				preferredStyle: .alert)
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
			
			let retryAction = UIAlertAction(
				title: "Retry",
				style: .default) { _ in
					self.retryRequest()
			}
			
			controller.addAction(retryAction)
			controller.addAction(cancelAction)
			self.present(controller, animated: true, completion: nil)
		}
	}
	
	func retryRequest() {
		self.view.backgroundColor = .gray
		
	}
	
}
