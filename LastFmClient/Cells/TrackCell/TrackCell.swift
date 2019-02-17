//
//  TrackCell.swift
//  LastFmClient
//
//  Created by Artem on 11/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
