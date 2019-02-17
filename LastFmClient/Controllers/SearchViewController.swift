//
//  SearchViewController.swift
//  LastFmClient
//
//  Created by Artem on 11/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    var searchController: UISearchController!
    var albums: [Album] = []
    var selectedAlbum: Album!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        self.tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        self.tableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 0 {
            NetworkManager.shared.getAlbums(searchString: text, completion: { albums in
                self.albums = albums!
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAlbum = albums[indexPath.row]
        self.performSegue(withIdentifier: "showDetailAlbum", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailAlbum" {
            let dc = segue.destination as! AlbumViewController
            dc.album = selectedAlbum
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        
        let album: Album = self.albums[indexPath.row]
        let viewModel: AlbumViewModel = AlbumViewModel(album: album)
        
        viewModel.configure(cell: cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }

}
    

