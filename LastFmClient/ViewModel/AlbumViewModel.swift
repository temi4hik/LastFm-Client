//
//  AlbumViewModel.swift
//  LastFm-Client
//
//  Created by Artem on 03/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

final class AlbumViewModel {
    private let album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    var name: String {
        return self.album.name
    }
    
    var artist: String {
        return self.album.artist
    }
    
    var link: URL {
        return self.album.url
    }
    
    var imageURL: URL? {
        return self.album.imageUrl
    }
    
    func configure(cell: AlbumCell) {
        if let imageUrl = self.imageURL {
            cell.albumImageView.af_setImage(withURL: imageUrl)
        } else {
            cell.albumImageView.image = UIImage(named: "default")
        }
        cell.albumNameLabel.text = self.name
        cell.albumArtistLabel.text = self.artist
    }
    
    func configure(cell: AlbumHeaderCell) {
        guard let album = self.album as? ExtendedAlbum else {
            return
        }
        
        if let imageUrl = self.imageURL {
            cell.albumImageView.af_setImage(withURL: imageUrl)
        } else {
            cell.albumImageView.image = UIImage(named: "default")
        }
        
        cell.albumArtistLabel.text = self.artist
        
        cell.tagsLabel.text = album.tags.joined(separator: ",")
    }
    
    
    func configure(cell: TrackCell, index: Int) {
        guard let album = self.album as? ExtendedAlbum else {
            return
        }
        let track = album.tracks[index]
        
        cell.nameLabel.text = track.name
        cell.numberLabel.text = "\(track.rank)"
        
        let minutes: Int = track.duration / 60;
        let seconds: Int = track.duration % 60;
        
        let secondsStr = String(format: "%02d", seconds)
        cell.lengthLabel.text = "\(minutes):\(secondsStr)"
    }
}
