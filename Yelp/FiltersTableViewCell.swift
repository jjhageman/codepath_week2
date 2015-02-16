//
//  FiltersTableViewCell.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/13/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

protocol FiltersSwitchCellDelegate: class {
    func filterSwitchCellDidToggle(cell: FiltersTableViewCell, newValue:Bool)
}

class FiltersTableViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    weak var delegate: FiltersSwitchCellDelegate?
    
    var filterRowIdentifier: FilterRowId! {
        didSet {
            filterLabel?.text = filterRowIdentifier?.rawValue
        }
    }
    
    @IBAction func didToggleSwitch(sender: AnyObject) {
        delegate?.filterSwitchCellDidToggle(self, newValue: filterSwitch.on)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
