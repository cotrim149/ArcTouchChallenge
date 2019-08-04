//
//  InfoCell.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 04/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

	@IBOutlet weak var posterimageView: UIImageView!
	@IBOutlet weak var originalTitleLabel: UILabel!
	@IBOutlet weak var genresLabel: UILabel!
	
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var releaseDateButton: UIButton!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
