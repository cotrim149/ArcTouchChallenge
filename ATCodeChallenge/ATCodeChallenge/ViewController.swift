//
//  ViewController.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 31/07/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		
//		tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")

		self.retrieveTMDbConfigurations()
	}

	override func viewDidAppear(_ animated: Bool) {
		self.retrieveUpcomingMovies()
	}
	
	func retrieveTMDbConfigurations() {
		TMDbConfigurationsDAO().retrieveConfigurations(completionHandler: {
			(configuration) in
			
			guard let imagesConfiguration = configuration.images else {
				return
			}
			
			if let baseUrl = imagesConfiguration.secureBaseUrl {
				URLProvider.baseImage = baseUrl
			} else {
				URLProvider.baseImage = "Base url cannot be retrived"
			}
			
			
		})
	}
	
	func retrieveUpcomingMovies() {
		let movieDAO = MoviesDAO()
		
		movieDAO.upcoming(inPage: 1, completionHandler: {
			(movies) in
			
			movieDAO.imageMovie(fromMovie: movies?.first, isPoster: true, completionHandler: {
				(imageData) in
				
				movies?.first?.posterImageData = imageData

			})
			
		})
		
	}

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)

		return movieCell
	}
	
	
}
