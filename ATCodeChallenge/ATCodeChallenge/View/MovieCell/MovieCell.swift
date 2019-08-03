//
//  MovieCell.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 02/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

	@IBOutlet weak var movieTitleLabel: UITextView!
	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var genresLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
