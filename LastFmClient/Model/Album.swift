//
//  Album.swift
//  LastFm-Client
//
//  Created by Artem on 03/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import Foundation

final class Album {
    let name: String
    let artist: String
    let imageUrl: URL?
    let url: URL
    
    var tracks: [Track]?
    
    
    init(name: String, artist: String, url: URL, imageUrl: URL?) {
        self.name = name
        self.artist = artist
        self.imageUrl = imageUrl
        self.url = url
    }
}
