//
//  AlbumViewController.swift
//  LastFmClient
//
//  Created by Artem on 11/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit

//showTrack
class AlbumViewController: UITableViewController {
    var album: Album!
    var extendedAlbum: ExtendedAlbum!
    
    var sections = ["AlbumHeaderCell", "TrackCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "AlbumHeaderCell", bundle: nil), forCellReuseIdentifier: "AlbumHeaderCell")
//        self.tableView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "SummaryCell")
        self.tableView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "TrackCell")

        self.navigationItem.title = self.album.name
        
        self.loadInfo()
        
    }
    
    func loadInfo() {
        NetworkManager.shared.getAlbumInfo(album: self.album, completion:  { alb in
            self.extendedAlbum = alb
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 167
        } else {
            return 80
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let alb = extendedAlbum else {
            return 0
        }
        return section == 0 ? 1 : alb.tracks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = self.extendedAlbum.tracks[indexPath.row]
        self.performSegue(withIdentifier: "showTrack", sender: track)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let track = sender as? Track, let vc = segue.destination as? TrackViewController {
            vc.track = track
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumHeaderCell", for: indexPath) as! AlbumHeaderCell
            
            let viewModel = AlbumViewModel(album: self.extendedAlbum)
            
            viewModel.configure(cell: cell)
            
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
            
            let viewModel = AlbumViewModel(album: self.extendedAlbum)
            
            viewModel.configure(cell: cell, index: indexPath.row)
            
            return cell
        }
    }

}
