//
//  Genre.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 03/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import ObjectMapper

class Genre: Mappable {
	var id:Int?
	var name:String?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		id <- map["id"]
		name <- map["name"]
	}
}
