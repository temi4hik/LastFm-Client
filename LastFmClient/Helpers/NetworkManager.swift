//
//  NetworkHelper.swift
//  LastFm-Client
//
//  Created by Artem on 03/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    private let apiKey: String = "30d74f42d1f0a32a6d98582a04f14b2b"
    
    private let host: String = "http://ws.audioscrobbler.com/2.0/"
    
    private let searchMethod: String = "album.search"
    
    private let infoMethod: String = "album.getInfo"
    
    private init() { }
    
    func getAlbumInfo(album: Album, completion: @escaping (ExtendedAlbum?) -> Void) -> Void {
        let urlStr = "\(self.host)?method=\(self.infoMethod)&api_key=\(self.apiKey)&artist=\(album.artist)&album=\(album.name)&format=json"
        let encodedUrl = urlStr.replacingOccurrences(of: " ", with: "%20")
        
        Alamofire.request(encodedUrl).responseJSON { response in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {
                return
            }
            
            let albumDict = json["album"] as! [String : AnyObject]
            let tracksDict = albumDict["tracks"] as! [String : AnyObject]
            let trackArray = tracksDict["track"] as! [[String : AnyObject]]
            var tracks: [Track] = []
            
            
            
            for trackDict in trackArray {
                let trackName = trackDict["name"] as! String
                let urlStr = trackDict["url"] as! String
                let url = URL(string: urlStr)!
                let durationStr: String = trackDict["duration"] as! String
                let duration: Int = Int(durationStr)!
                let attr = trackDict["@attr"] as! [String : String]
                let rankStr = attr["rank"]!
                let rank = Int(rankStr)!
                let track = Track(name: trackName, url: url, duration: duration, rank: rank)

                tracks.append(track)
            }
            
            let tagDict = albumDict["tags"] as! [String : AnyObject]
            let tagsArray = tagDict["tag"] as! [[String : String]]
            
            var tags: [String] = []
            for tagDict in tagsArray {
                let tagName = tagDict["name"]!
                tags.append(tagName)
            }
            
            let extendedAlbum: ExtendedAlbum = ExtendedAlbum(name: album.name, artist: album.artist, url: album.url, imageUrl: album.imageUrl, tags: tags, summary: "", tracks: tracks)
            
            completion(extendedAlbum)
        }
    }
    
    
    func getAlbums(searchString: String, completion: @escaping ([Album]?) -> Void) -> Void {
        let urlStr = "\(self.host)?method=\(self.searchMethod)&album=\(searchString)&api_key=\(self.apiKey)&format=json"
        
        let encodedUrl = urlStr.replacingOccurrences(of: " ", with: "%20")
        
        
        Alamofire.request(encodedUrl).responseJSON { response in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {
                return
            }
            
            let results: [String : AnyObject] = json["results"] as! [String : AnyObject]
            let albumMatches: [String : AnyObject] = results["albummatches"] as! [String : AnyObject]
            let albumArray: [[String : AnyObject]] = albumMatches["album"] as! [[String : AnyObject]]
            
            var albums: [Album] = []
            
            for albumDict in albumArray {
                let name: String = albumDict["name"] as! String
                let artist: String = albumDict["artist"] as! String
                let urlStr: String = albumDict["url"] as! String
                let url: URL = URL(string: urlStr)!
                
                let imageArray: [[String : String]] = albumDict["image"] as! [[String : String]]
                var imageUrlStr: String?
                for i in stride(from: imageArray.count - 1, through: 0, by: -1) {
                    if let urlStr = imageArray[i]["#text"] {
                        if urlStr.count == 0 {
                            continue
                        } else {
                            imageUrlStr = urlStr
                            break
                        }
                    }
                }
                
                var imageUrl: URL? = nil
                
                if let imageUrlStr = imageUrlStr {
                    imageUrl = URL(string: imageUrlStr)
                }
                
                let album: Album = Album(name: name, artist: artist, url: url, imageUrl: imageUrl)
                
                albums.append(album)
            }
            completion(albums)
        }
    }
}
