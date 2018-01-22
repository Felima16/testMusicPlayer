//
//  MusicTableViewController.swift
//  MusicPlayer_Publicista
//
//  Created by Fernanda de Lima on 20/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

class MusicTableViewController: UITableViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var themes = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        loadTracks()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mm.response?.results?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicViewCell
        cell.artistLabel.text = mm.response?.results![indexPath.row].artistName
        cell.songLabel.text = mm.response?.results![indexPath.row].trackName
        cell.playButton.tag = indexPath.row
        return cell
    }
    
    private func initTable(){
        activityIndicator.center = CGPoint(x: self.tableView.center.x, y: 10)
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.hidesWhenStopped = true
        self.tableView.addSubview(activityIndicator)
        
        self.tableView.register(UINib(nibName: "MusicViewCell", bundle: nil), forCellReuseIdentifier: "musicCell")
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadTracks(){
        activityIndicator.startAnimating()
        self.view.alpha = 0.5
        UIApplication.shared.beginIgnoringInteractionEvents()
        let url = "https://itunes.apple.com/search?term=\(themes)&entity=song"
        iTunnesAPI.get(Response.self, url: url, finish: {
            self.activityIndicator.stopAnimating()
            self.view.alpha = 1.0
            UIApplication.shared.endIgnoringInteractionEvents()
        }, success: { (item) in
            mm.response = item
            self.tableView.reloadData()
        }) { (error, code) in
            print("--- error \(error.localizedDescription) --- code \(code ?? 0)")
        }
        
        self.activityIndicator.stopAnimating()
        self.view.alpha = 1.0
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    

}
