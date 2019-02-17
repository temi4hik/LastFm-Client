//
//  AlbumHeaderCell.swift
//  LastFm-Client
//
//  Created by Artem on 03/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit

class AlbumHeaderCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var albumArtistLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
