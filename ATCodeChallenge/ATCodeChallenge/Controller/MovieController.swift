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
	func finishUpcomingMovies()
	func selectedMovie() -> Int
}

class MovieController: NSObject {

	var movies : [Movie] = []
	var filteredMovies: [Movie] = []
	var isSearchActive = false
	var genresDict = [Int:Genre]()
	var delegate: MovieControllerDelegate?
	let movieDAO = MoviesDAO()
	var currentPage = 0
	
	// MARK: - Retrieve methods
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
	
	/**
		Retrive the upcoming movies always incrementing the page number in 1. The method always append the new content to the older content.
	*/
	func retrieveUpcomingMovies() {
		
		currentPage += 1
		
		movieDAO.upcoming(inPage: currentPage, completionHandler: {
			(movies) in
			
			if(self.movies.isEmpty) {
				self.movies = movies ?? []
			} else {
				self.movies.append(contentsOf: movies ?? [])
			}
			
			for (_, movie) in self.movies.enumerated() {
				self.updateMovie(movie: movie)
			}
			self.delegate?.finishUpcomingMovies()
		})
		
	}
}

//	MARK: - Update methods
extension MovieController {

	private func updateMovie(movie:Movie) {
		self.updatePosterImage(movie: movie)
		if(genresDict.isEmpty) {
			retrieveGenres()
		}
		self.updateGenres(movie: movie)
	}
	
	/**
	Updating the poster image from the movie object. If the movie already have that image
	then the request not happens.
	*/
	private func updatePosterImage(movie:Movie) {
		if (movie.posterImageData != nil) {
			return
		}
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
}

extension MovieController {
	func updateFilteredMovies(movieName: String) {

		if(movieName.isEmpty) {
			self.filteredMovies.removeAll()
			isSearchActive = false
		} else {
			self.filteredMovies = self.movies.filter { (movie) -> Bool in
				(movie.title?.contains(movieName))!
			}
			isSearchActive = true
		}

		self.delegate?.updateUpcomingMovies()
	}
}
