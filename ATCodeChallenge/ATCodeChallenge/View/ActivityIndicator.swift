//
//  ActivityIndicator.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 03/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class ActivityIndicator: NSObject {

	private var activityIndicator: UIActivityIndicatorView!
	private var containerView: UIView!
	
	func show(inViewController controller: UIViewController) {
		containerView = UIView(frame: controller.view.bounds)
		containerView.backgroundColor = .black
		containerView.alpha = 0.5
		
		controller.view.addSubview(containerView)
		
		self.showActivityIndicatory(uiView: containerView)
	}

	func hide() {
		activityIndicator.stopAnimating()
		containerView.removeFromSuperview()
	}
	
	private func showActivityIndicatory(uiView: UIView) {
		self.activityIndicator = UIActivityIndicatorView()
		activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
		activityIndicator.center = uiView.center
		activityIndicator.hidesWhenStopped = true
		activityIndicator.style = .whiteLarge
		uiView.addSubview(activityIndicator)
		
		activityIndicator.startAnimating()
	}
}
