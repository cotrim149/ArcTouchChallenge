//
//  TMDbConfigurationsDAO.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 01/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class TMDbConfigurationsDAO: NSObject {

	func retrieveConfigurations(completionHandler completion: @escaping (_ configuration: Configuration)->Void) {
		let apiKey = URLProvider.apiKey
		let url = URLProvider.configurations(apiKey: apiKey)
		
		Alamofire.request(url).responseObject { (response: DataResponse<Configuration>) in
			guard let configuration = response.result.value else {
				return
			}
			
			completion(configuration)
		}
	}
}

extension URLProvider {
	static func configurations(apiKey:String) -> URL {
		
		guard let url = URL(string: URLProvider.base.appending("/configuration?api_key=\(apiKey)")) else {
			return URL(string:"Configuration URL cannot be instancied")!
		}
		
		return url
	}
}
