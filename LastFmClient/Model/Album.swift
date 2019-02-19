//
//  Album.swift
//  LastFm-Client
//
//  Created by Artem on 03/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import Foundation


class Album {
    let name: String
    let artist: String
    let imageUrl: URL?
    let url: URL
    
    init(name: String, artist: String, url: URL, imageUrl: URL?) {
        self.name = name
        self.artist = artist
        self.imageUrl = imageUrl
        self.url = url
    }
}

final class ExtendedAlbum: Album {
    let tags: [String]
    let summary: String
    let tracks: [Track]
    
    
    
    init(name: String, artist: String, url: URL, imageUrl: URL?, tags: [String], summary: String, tracks: [Track]) {
        self.tags = tags
        self.summary = summary
        self.tracks = tracks
        super.init(name: name, artist: artist, url: url, imageUrl: imageUrl)
        
    }
}

