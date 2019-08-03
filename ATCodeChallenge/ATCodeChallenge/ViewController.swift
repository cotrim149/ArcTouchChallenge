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
	let activityIndicator = ActivityIndicator()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		
		self.movieController = MovieController()
		self.movieController.delegate = self
		self.movieController.retrieveTMDbConfigurations()
	}

	override func viewWillAppear(_ animated: Bool) {
		activityIndicator.show(inViewController: self)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.movieController.retrieveUpcomingMovies()
	}
	
	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		self.tableView.reloadData()
	}
	

}

extension ViewController: MovieControllerDelegate {
	func finishUpcomingMovies() {
		self.activityIndicator.hide()
	}
	
	func updateUpcomingMovies() {
		self.tableView.reloadData()
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

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		
		if offsetY > contentHeight - scrollView.frame.size.height {
			activityIndicator.show(inViewController: self)
			self.movieController.retrieveUpcomingMovies()
		}
		
	}
	
}


extension ViewController {
	private func produceGenresString(movie:Movie) -> String {
		var genresText = ""
		for genre in movie.genres {
			genresText = "\(genresText) \(genre)"
		}
		return genresText
	}
	
	func setupMovieCellPortrait(tableView:UITableView, indexPath:IndexPath) -> MovieCell{
		let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
		
		let movie = self.movieController.movies[indexPath.row]
		movieCell.movieTitleLabel.text = movie.title
		
		if let posterImageData = movie.posterImageData {
			movieCell.posterImageView.image = UIImage(data: posterImageData)
		}
		
		movieCell.releaseDateLabel.text = movie.releaseDate
		
		movieCell.genresLabel.text = self.produceGenresString(movie: movie)
		
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
		
		movieCell.genresLabel.text = self.produceGenresString(movie: movie)
		
		movieCell.movieOverviewLabel.text = movie.overview
		
		return movieCell
	}
}
