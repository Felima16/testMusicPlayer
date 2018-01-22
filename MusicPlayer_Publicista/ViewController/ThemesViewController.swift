//
//  ViewController.swift
//  MusicPlayer_Publicista
//
//  Created by Fernanda de Lima on 20/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {

    @IBOutlet weak var themesCollectionView: UICollectionView!
    let themes = ["rock","pop", "indie", "country", "blues", "eletronic", "tones"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkIAP()
    }
    
    private func checkIAP(){
        if IAPHandler.shared.canMakePurchases(){
            print("Liberado para gastar")
        }else{
            print("Ta pobre")
        }
    }
}

extension ThemesViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "themesCell", for: indexPath) as! ThemesCollectionViewCell
        cell.nameThemeLabel.text = self.themes[indexPath.row]
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "musicTableView") as! MusicTableViewController
        tableView.themes = self.themes[indexPath.row]
        self.navigationController?.pushViewController(tableView, animated: true)
    }
}
