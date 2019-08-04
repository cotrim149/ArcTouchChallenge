//
//  DetailMovieViewController.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 03/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

	var movie : Movie?
	let controller = MovieDetailController()
	let activityIndicator = ActivityIndicator()

	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
        super.viewDidLoad()
		controller.delegate = self
		tableView.delegate = self
		tableView.dataSource = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		activityIndicator.show(inViewController: self)
		controller.retrieveDetail(ofMovie: movie)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		controller.stopRequests()
		controller.stopDownloads()
	}

	override func viewDidDisappear(_ animated: Bool) {
		activityIndicator.hide()
	}
}

extension DetailMovieViewController: MovieDetailDelegate {

	func updateMovie(movie: Movie) {

		movie.genres = self.movie?.genres
		movie.posterImageData = self.movie?.posterImageData
		movie.backdropImageData = self.movie?.backdropImageData
		
		self.movie = movie
		self.tableView.reloadData()
		activityIndicator.hide()
	}
	
}

extension DetailMovieViewController {
	func setupBackdropImage(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ImageViewCell {
		let backdropImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
		if let data = self.movie?.backdropImageData {
			backdropImageCell.backdropImageView.image = UIImage(data: data)
		} else {
			backdropImageCell.backdropImageView.image = UIImage(named: "ImagePlaceholder")
		}
		
		return backdropImageCell
	}
	
	func setupInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InfoCell {
		
		let infoCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
		
		infoCell.genresLabel.text = MovieStringHelper.produceGenresString(movie: self.movie)
		
		infoCell.originalTitleLabel.text = movie?.originalTitle
		
		if let data = self.movie?.posterImageData {
			infoCell.posterimageView.image = UIImage(data: data)
		} else {
			infoCell.posterimageView.image = UIImage(named: "ImagePlaceholder")
		}
		
		if let voteAvarage = self.movie?.voteAverage {
			infoCell.rateLabel.text = "\(voteAvarage)/10"
		}
		
		infoCell.statusLabel.text = self.movie?.status
		infoCell.releaseDateButton.setTitle(self.movie?.releaseDate, for: .normal)
		
		return infoCell
	}
	
	func setupOverviewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> OverviewCell {
		
		let overviewCell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as! OverviewCell
		
		overviewCell.overviewTextView.text = self.movie?.overview
		
		return overviewCell
	}
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		switch indexPath.row {
		case 0:
			return setupBackdropImage(tableView, cellForRowAt: indexPath)
		case 1:
			return setupInfoCell(tableView, cellForRowAt: indexPath)
		case 2:
			return setupOverviewCell(tableView, cellForRowAt: indexPath)
		default:
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.row {
		case 0:
			return 228.0
		case 1:
			return 280.0
		case 2:
			return 320.0
		default:
			return 0
		}
	}
	
}
