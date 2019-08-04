//
//  MovieCellLandscape.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 03/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class MovieCellLandscape: UITableViewCell {

	@IBOutlet weak var posterImageView: UIImageView!
	
	@IBOutlet weak var movieTitleLabel: UITextView!
	@IBOutlet weak var genresLabel: UILabel!
	@IBOutlet weak var releaseDateLabel: UILabel!

	@IBOutlet weak var movieOverviewLabel: UITextView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
