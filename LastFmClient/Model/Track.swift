//
//  Track.swift
//  LastFm-Client
//
//  Created by Artem on 03/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import Foundation

class Track {
    weak var album: Album?
    let url: URL
    let duration: Int
    
    init(url: URL, duration: Int) {
        self.url = url
        self.duration = duration
    }
}
