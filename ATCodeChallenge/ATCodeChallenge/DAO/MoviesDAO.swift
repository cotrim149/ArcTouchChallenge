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
	
	func imageMovie(fromMovie: Movie?, isPoster: Bool) -> Data? {
		
		guard let movie = fromMovie else {
			return nil
		}
		
		var imageSize = ""
		var filePath = ""
		if(isPoster) {
			imageSize = "w300"
			filePath = movie.posterPath ?? "poster image is empty"
		} else {
			imageSize = "w300"
			filePath = movie.backdropPath ?? "backdrop image is empty"
		}
		
		let url = URLProvider.imageMovie(withSize: imageSize, inFilePath: filePath)
		
		let imageData = Alamofire.download(url).responseData().result.value

		return imageData
		
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

}
