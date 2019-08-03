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
		
		let url = URLProvider.upcomingMovies(withApiKey: apiKey, language: language, forPage: page)
		Alamofire.request(url).responseObject { (response: DataResponse<UpcomingMovies>) in

			guard let upcomingMovies = response.result.value else {
				return
			}
			
			completion(upcomingMovies.movies)

		}
	}
	

	func imageMovie(fromMovie: Movie?, isPoster: Bool, completionHandler completion: @escaping (_ imageData: Data)->Void) {
		
		guard let movie = fromMovie else {
			return
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
		
		let url = URLProvider.imageMovie(withSize: imageSize, inFilePath: filePath)

		let destination: DownloadRequest.DownloadFileDestination = { _, _ in
			let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
			let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
			let fileURL = documentsURL.appendingPathComponent("\(filePath).png")
			
			return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
		}

		Alamofire.download(url, to: destination).responseData { (response) in
			guard let dataImage = response.result.value else {
//				completion(placeholder image)
				return
			}

			completion(dataImage)
		}
		
	}
	
	func genres() -> [Genre]{
		let apiKey = URLProvider.apiKey
		let language = "en-US"

		let url = URLProvider.genresMovie(withApiKey: apiKey, language: language)
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
	
	static func upcomingMovies(withApiKey apiKey:String, language:String, forPage page:Int) -> URL {
		
		guard let url = URL(string: URLProvider.baseMovies.appending("/upcoming?api_key=\(apiKey)&language=\(language)&page=\(page)")) else {
			
			return URL(string: "UpcomingMovies URL cannot be instancied")!
		}
		
		return url
	}
	
	static func imageMovie(withSize size: String, inFilePath filePath: String) -> URL {
		guard let url = URL(string: URLProvider.baseImage.appending("\(size)\(filePath)")) else {
			return URL(string: "ImageMovie URL cannot be instancied")!
		}
		
		return url
	}
	
	static func genresMovie(withApiKey apiKey:String, language:String) -> URL {
		guard let url = URL(string: URLProvider.baseGenres.appending("?api_key=\(apiKey)&language=\(language)")) else {
			
			return URL(string: "GenresMovies URL cannot be instancied")!
		}
		
		return url
	}

}
