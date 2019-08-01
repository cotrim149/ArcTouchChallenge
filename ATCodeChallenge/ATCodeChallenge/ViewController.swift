//
//  ViewController.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 31/07/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.retrieveUpcomingMovies()
	}

	func retrieveUpcomingMovies() {
		
		MoviesDAO().upcoming(inPage: 1)
	}

}

