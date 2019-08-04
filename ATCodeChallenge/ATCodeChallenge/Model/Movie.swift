//
//  Movie.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 31/07/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import ObjectMapper

class Movie: Mappable {

	// MARK:- Upcoming movie
	var adult : Bool?
	var backdropPath : String?
	var genreIds : [Int]?
	var id : Int?
	var originalLanguage : String?
	var originalTitle : String?
	var overview : String?
	var popularity : Double?
	var posterPath : String?
	var releaseDate : String?
	var title : String?
	var video : Bool?
	var voteAverage : Double?
	var voteCount : Int?
	
	// MARK:- Details
	var belongsToCollection : String?
	var budget : Int?
	var homepage : String?
	var imdbId : String?
	var productionCompanies : [ProductionCompanies]?
	var productionCountries : [String]?
	var revenue : Int?
	var runtime : Int?
	var spokenLanguages : [SpokenLanguages]?
	var status : String?
	var tagline : String?
	
	// MARK:- Custom variables
	var posterImageData : Data?
	var backdropImageData : Data?
	var genres:[String]!
	
	init() {
	}
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {

		// upcoming movie
		voteCount <- map["vote_count"]
		id <- map["id"]
		video <- map["video"]
		voteAverage <- map["vote_average"]
		title <- map["title"]
		popularity <- map["popularity"]
		posterPath <- map["poster_path"]
		originalLanguage <- map["original_language"]
		originalTitle <- map["original_title"]
		genreIds <- map["genre_ids"]
		backdropPath <- map["backdrop_path"]
		adult <- map["adult"]
		overview <- map["overview"]
		releaseDate <- map["release_date"]
		
		// details
		belongsToCollection <- map["belongs_to_collection"]
		budget <- map["budget"]
		homepage <- map["homepage"]
		imdbId <- map["imdb_id"]
		productionCompanies <- map["production_companies"]
		productionCountries <- map["production_countries"]
		revenue <- map["revenue"]
		runtime <- map["runtime"]
		spokenLanguages <- map["spoken_languages"]
		status <- map["status"]
		tagline <- map["tagline"]
		
	}
	
}

//{
//	"belongs_to_collection": null,
//	"budget": 200000000,
//	"homepage": "https://www.hobbsandshawmovie.com",
//	"imdb_id": "tt6806448",
//	"production_companies": [
//	{
//	"id": 33,
//	"logo_path": "/8lvHyhjr8oUKOOy2dKXoALWKdp0.png",
//	"name": "Universal Pictures",
//	"origin_country": "US"
//	}
//	],
//	"production_countries": [],
//	"release_date": "2019-08-01",
//	"revenue": 0,
//	"runtime": 133,
//	"spoken_languages": [
//	{
//	"iso_639_1": "en",
//	"name": "English"
//	},
//	{
//	"iso_639_1": "it",
//	"name": "Italiano"
//	}
//	],
//	"status": "Released",
//	"tagline": "",
//	"vote_count": 150
//}
