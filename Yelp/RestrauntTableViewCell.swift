//
//  RestrauntTableViewCell.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/10/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class RestrauntTableViewCell: UITableViewCell {

    @IBOutlet weak var restrauntNameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var restrauntThumb: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
