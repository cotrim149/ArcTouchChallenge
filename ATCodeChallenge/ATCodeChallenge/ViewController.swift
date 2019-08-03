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
	
	var movies : [Movie] = []
	
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

			self.movies = movies ?? []

			for (index, movie) in self.movies.enumerated() {

				movieDAO.imageMovie(fromMovie: movie, isPoster: true, completionHandler: {
					(imageData) in
					
					movie.posterImageData = imageData
					self.tableView.reloadData()
					print("Image of \(String(describing: movie.title)): \(imageData) load!")
//					self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
					
				})
			}
		

			
		})
		
	}

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.movies.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
		let movie = self.movies[indexPath.row]
		movieCell.movieTitleLabel.text = movie.title

		if let posterImageData = movie.posterImageData {
			movieCell.posterImageView.image = UIImage(data: posterImageData)
		}
		
		return movieCell
	}
	
	
}
