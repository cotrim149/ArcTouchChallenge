//
//  MoviesDAO.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 31/07/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Alamofire_Synchronous

class MoviesDAO: NSObject {
	
	func upcoming(inPage page:Int, completionHandler completion: @escaping (_ movies:[Movie]?)->Void) {
		let apiKey = URLProvider.apiKey
		let language = "en-US"
		
		guard let url = URLProvider.upcomingMovies(withApiKey: apiKey, language: language, forPage: page) else {
			completion([])
			return
		}
		
		
		Alamofire.request(url).responseObject { (response: DataResponse<UpcomingMovies>) in

			guard let upcomingMovies = response.result.value else {
				return
			}
			completion(upcomingMovies.movies)

		}
	}
	
	func details(withMovieId movieId: Int, completionHandler completion: @escaping (_ movie: Movie)->Void) -> DataRequest? {
		let apiKey = URLProvider.apiKey
		let language = "en-US"
		
		guard let url = URLProvider.detailMovie(withApiKey: apiKey, movieId: movieId, language: language) else {
			return nil
		}

		return Alamofire.request(url).responseObject { (response:DataResponse<Movie>) in
			guard let movie = response.result.value else {
				return
			}
			
			completion(movie)
		}
		
	}

	func imageMovie(fromMovie: Movie?, isPoster: Bool, completionHandler completion: @escaping (_ imageData: Data)->Void) -> DownloadRequest?{
		
		guard let movie = fromMovie else {
			return nil
		}
		
		var imageSize = ""
		var filePath = ""
		if(isPoster) {
			imageSize = "w185"
			filePath = movie.posterPath ?? "poster image is empty"
		} else {
			imageSize = "w300"
			filePath = movie.backdropPath ?? "backdrop image is empty"
		}
		
		guard let url = URLProvider.imageMovie(withSize: imageSize, inFilePath: filePath) else {
//				completion(placeholder image)
			completion(Data())
			return nil
		}

		let destination: DownloadRequest.DownloadFileDestination = { _, _ in
			let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
			let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
			let fileName = filePath.dropFirst()
			let fileURL = documentsURL.appendingPathComponent("\(fileName)")
			
			return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
		}

		let dataRequest = Alamofire.download(url, to: destination).responseData { (response) in
			guard let dataImage = response.result.value else {
//				completion(placeholder image)
				return
			}

			completion(dataImage)
		}
		
		return dataRequest
	}
	
	func genres() -> [Genre]{
		let apiKey = URLProvider.apiKey
		let language = "en-US"

		guard let url = URLProvider.genresMovie(withApiKey: apiKey, language: language) else {
			return []
		}
		
		let response = Alamofire.request(url).responseJSON()
		var genres:[Genre] = []

		if let genresJson:[String:[Any]] = response.result.value as? [String:[Any]]{
			
			let genresArrayJson = genresJson["genres"] as? [[String:Any]]
			
			for genreJson in genresArrayJson! {
				if let genre = Genre(JSON: genreJson){
					genres.append(genre)
				}
			}

		}
		
		return genres
	}
}

extension URLProvider {
	
	static func upcomingMovies(withApiKey apiKey:String, language:String, forPage page:Int) -> URL? {
		
		guard let url = URL(string: URLProvider.baseMovies.appending("/upcoming?api_key=\(apiKey)&language=\(language)&page=\(page)")) else {
			
			return URL(string: "UpcomingMovies URL cannot be instancied")
		}
		
		return url
	}
	
	static func detailMovie(withApiKey apiKey: String, movieId: Int, language: String) -> URL? {
		
		guard let url = URL(string: URLProvider.baseMovies.appending("/\(movieId)?api_key=\(apiKey)&language=\(language)")) else {
			return URL(string:"DetailMovie URL cannot be instacied")
		}
		
		return url
		
	}
	
	static func imageMovie(withSize size: String, inFilePath filePath: String) -> URL? {
		guard let url = URL(string: URLProvider.baseImage.appending("\(size)\(filePath)")) else {
			return URL(string: "ImageMovie URL cannot be instancied")
		}
		
		return url
	}
	
	static func genresMovie(withApiKey apiKey:String, language:String) -> URL? {
		guard let url = URL(string: URLProvider.baseGenres.appending("?api_key=\(apiKey)&language=\(language)")) else {
			
			return URL(string: "GenresMovies URL cannot be instancied")
		}
		
		return url
	}

}
