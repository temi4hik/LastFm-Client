//
//  TrackViewController.swift
//  LastFmClient
//
//  Created by Artem on 17/02/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit
import WebKit

class TrackViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    weak var track: Track!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.track.name
        let request: URLRequest = URLRequest(url: self.track.url)
        self.webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
