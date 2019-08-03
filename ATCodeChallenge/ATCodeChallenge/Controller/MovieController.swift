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
	var genresDict = [Int:Genre]()
	var delegate: MovieControllerDelegate?
	let movieDAO = MoviesDAO()

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
	
	private func retrieveGenres() {
		let genres = movieDAO.genres()
		
		for genre in genres {
			if let key = genre.id {
				genresDict[key] = genre
			}
		}
		
	}
	
	private func updateMovie(movie:Movie) {
		self.updateImage(movie: movie)
		if(genresDict.isEmpty) {
			retrieveGenres()
		}
		self.updateGenres(movie: movie)
	}
	
	private func updateImage(movie:Movie) {
		movieDAO.imageMovie(fromMovie: movie, isPoster: true, completionHandler: {
			(imageData) in
			
			movie.posterImageData = imageData
			self.delegate?.updateUpcomingMovies()
			
		})
	}
	
	private func updateGenres(movie:Movie) {
		if let genresId = movie.genreIds {
			var genresString:[String?] = [String?]()
			
			for genreId in genresId {
				let genre = genresDict[genreId]
				genresString.append(genre?.name)
			}
			movie.genres = genresString as? [String]
		}

	}
	
	func retrieveUpcomingMovies() {

		movieDAO.upcoming(inPage: 1, completionHandler: {
			(movies) in
			self.movies = movies ?? []
			for (_, movie) in self.movies.enumerated() {
				self.updateMovie(movie: movie)
			}
		})
		
	}
}
