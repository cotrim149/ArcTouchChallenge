//
//  MovieStringHelper.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 04/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class MovieStringHelper {

	static func produceGenresString(movie unwrppedMovie:Movie?) -> String {
		
		guard let movie = unwrppedMovie else {
			return "Cannot produces genres string."
		}
		
		var genresText = ""
		for genre in movie.genres {
			genresText = "\(genresText) \(genre)"
		}
		return genresText
	}
}
