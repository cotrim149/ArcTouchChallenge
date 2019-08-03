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
	var movieController:MovieController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self

		self.movieController = MovieController()
		self.movieController.delegate = self
		self.movieController.retrieveTMDbConfigurations()
	}

	override func viewDidAppear(_ animated: Bool) {
		self.movieController.retrieveUpcomingMovies()
	}
	
	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		self.tableView.reloadData()
	}
	

}

extension ViewController: MovieControllerDelegate {
	func updateUpcomingMovies() {
		self.tableView.reloadData()
	}
}

extension ViewController {
	func setupMovieCellPortrait(tableView:UITableView, indexPath:IndexPath) -> MovieCell{
		let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
		
		let movie = self.movieController.movies[indexPath.row]
		movieCell.movieTitleLabel.text = movie.title
		
		if let posterImageData = movie.posterImageData {
			movieCell.posterImageView.image = UIImage(data: posterImageData)
		}
		
		movieCell.releaseDateLabel.text = movie.releaseDate
		
		var genresText = ""
		for genre in movie.genres {
			genresText = "\(genresText) \(genre)"
		}
		movieCell.genresLabel.text = genresText
		
		return movieCell
	}
	
	func setupMovieCellLandscape(tableView:UITableView, indexPath:IndexPath) -> MovieCellLandscape {
		let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCellLandscape", for: indexPath) as! MovieCellLandscape
		
		let movie = self.movieController.movies[indexPath.row]
		movieCell.movieTitleLabel.text = movie.title
		
		if let posterImageData = movie.posterImageData {
			movieCell.posterImageView.image = UIImage(data: posterImageData)
		}
		
		movieCell.releaseDateLabel.text = movie.releaseDate
		
		movieCell.movieOverviewLabel.text = movie.overview
		
		return movieCell
	}
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.movieController.movies.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if(UIApplication.shared.statusBarOrientation.isPortrait) {
			return self.setupMovieCellPortrait(tableView: tableView, indexPath: indexPath)
		} else {
			return self.setupMovieCellLandscape(tableView: tableView, indexPath: indexPath)
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if(UIApplication.shared.statusBarOrientation.isPortrait) {
			return 410.0
		} else {
			return 390.0
		}
	}
	
}
