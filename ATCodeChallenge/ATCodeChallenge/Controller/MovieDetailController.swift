//
//  MovieDetailController.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 04/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import Alamofire

protocol MovieDetailDelegate {
	func updateMovie(movie:Movie)
}

class MovieDetailController: NSObject {

	let movieDAO = MoviesDAO()
	var delegate: MovieDetailDelegate?
	var doingRequests : [DataRequest?] = []
	var doingDownloads : [DownloadRequest?] = []
	
	func retrieveDetail(ofMovie movie:Movie?) {
		
		guard let movieId = movie?.id else {
			// return error movie retrivied without ID
			return
		}
		
		let movieDetailRequest = movieDAO.details(withMovieId: movieId, completionHandler: {
			movie in
			
			self.retrieveBackdropImage(fromMovie: movie)
			
		})
		
		doingRequests.append(movieDetailRequest)
	}
	
	func retrieveBackdropImage(fromMovie movie: Movie?) {
		
		let imageDownloadRequest = movieDAO.imageMovie(fromMovie: movie, isPoster: false) { (imageData) in
			
			guard let wrappedMovie = movie else {
				return
			}
			
			wrappedMovie.backdropImageData = imageData
			self.delegate?.updateMovie(movie: wrappedMovie)
		}

		doingDownloads.append(imageDownloadRequest)

	}
	
	func stopRequests() {
		for request in doingRequests {
			
			guard let isCancellable = request?.progress.isCancellable else{
				continue
			}
			
			if isCancellable{
				request?.cancel()
			}
		}
	}
	
	func stopDownloads() {
		for download in doingDownloads {
			guard let isCancellable = download?.progress.isCancellable else {
				continue
			}
			
			if isCancellable {
				download?.cancel()
			}
		}
	}
}
