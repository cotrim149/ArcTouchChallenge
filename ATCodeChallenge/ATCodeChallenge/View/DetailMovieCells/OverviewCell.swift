//
//  OverviewCell.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 04/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {

	@IBOutlet weak var overviewTextView: UITextView!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
