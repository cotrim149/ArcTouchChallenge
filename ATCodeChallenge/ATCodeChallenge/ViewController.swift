//
//  ViewController.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 31/07/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var posterImage: UIImageView!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.retrieveTMDbConfigurations()
	}

	override func viewDidAppear(_ animated: Bool) {
		self.retrieveUpcomingMovies()
	}
	
	func retrieveTMDbConfigurations() {
		TMDbConfigurationsDAO().retrieveConfigurations(completionHandler: {
			(configuration) in
			
			guard let imagesConfiguration = configuration.images else {
				return
			}
			
			if let baseUrl = imagesConfiguration.secureBaseUrl {
				URLProvider.baseImage = baseUrl
			} else {
				URLProvider.baseImage = "Base url cannot be retrived"
			}
			
			
		})
	}
	
	func retrieveUpcomingMovies() {
		let movieDAO = MoviesDAO()
		
		movieDAO.upcoming(inPage: 1, completionHandler: {
			(movies) in
			
			movieDAO.imageMovie(fromMovie: movies?.first, isPoster: true, completionHandler: {
				(imageData) in
				
				movies?.first?.posterImageData = imageData
				
				self.posterImage.image = UIImage(data: imageData)

			})
			
		})
		
	}

}

