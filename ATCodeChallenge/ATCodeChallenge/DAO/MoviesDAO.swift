//
//  MoviesDAO.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 31/07/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import Alamofire

class MoviesDAO: NSObject {
	
	func upcoming(inPage page:Int) {
		let apiKey = "1f54bd990f1cdfb230adb312546d765d"
		let language = "en-US"
		
		let url = URLProvider.upcomingMovies(withApiKey: apiKey, language: language, forPage: page)
		Alamofire.request(url).responseJSON { (response) in
			print(response);
		}
	}
}

extension URLProvider {
	
	static func upcomingMovies(withApiKey apiKey:String, language:String, forPage page:Int) -> URL {
		return URL(string: URLProvider.baseMovies.appending("/upcoming?api_key=\(apiKey)&language=\(language)&page=\(page)"))!
	}
}
