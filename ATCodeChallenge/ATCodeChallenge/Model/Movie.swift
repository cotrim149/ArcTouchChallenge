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
	var voteCount : Int?
	var id : Int?
	var video : Bool?
	var voteAverage : Double?
	var title : String?
	var popularity : Double?
	var posterPath : String?
	var originalLanguage : String?
	var originalTitle : String?
	var genreIds : [Int]?
	var backdropPath : String?
	var adult : Bool?
	var overview : String?
	var releaseDate : String?
	
	var posterImageData : Data?
	var backdropImageData : Data?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		
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
	}
	
}

//{
//	vote_count: 28,
//	id: 384018,
//	video: false,
//	vote_average: 6.7,
//	title: "Velozes & Furiosos: Hobbs & Shaw",
//	popularity: 109.277,
//	poster_path: "/keym7MPn1icW1wWfzMnW3HeuzWU.jpg",
//	original_language: "en",
//	original_title: "Fast & Furious Presents: Hobbs & Shaw",
//	genre_ids: [
//	28
//	],
//	backdrop_path: "/fgPZgeqxDKIw86pBiAyLhh0vTrU.jpg",
//	adult: false,
//	overview: "Desde que se conheceram, em "Velozes & Furiosos 7", Luke Hobbs (Dwayne Johnson) e Deckard Shaw (Jason Statham) constantemente bateram de frente, não só por inicialmente estarem em lados opostos mas, especialmente, pela personalidade de cada um. Agora, a dupla precisa unir forças para enfrentar Brixton (Idris Elba), um anarquista alterado geneticamente que se tornou uma ameaça biológica global. Para tanto, eles contam com a ajuda de Hattie (Vanessa Kirby), irmã de Shaw, que é também agente do MI6, o serviço secreto britânico.",
//	release_date: "2019-08-01"
//}
