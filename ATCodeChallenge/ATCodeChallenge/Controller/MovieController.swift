//
//  MovieController.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 03/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
protocol MovieControllerDelegate {
	func updateUpcomingMovies()
}

class MovieController: NSObject {

	var movies : [Movie] = []

	var delegate: MovieControllerDelegate?
	
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
	
	func retrieveGenres() {
		
		MoviesDAO().genres()
	}
	
	func retrieveUpcomingMovies() {
		let movieDAO = MoviesDAO()
		movieDAO.upcoming(inPage: 1, completionHandler: {
			(movies) in
			
			self.movies = movies ?? []
			
			for (_, movie) in self.movies.enumerated() {
				
				movieDAO.imageMovie(fromMovie: movie, isPoster: true, completionHandler: {
					(imageData) in
					
					movie.posterImageData = imageData
					self.delegate?.updateUpcomingMovies()
					
				})
			}
			
			
		})
		
	}
}
