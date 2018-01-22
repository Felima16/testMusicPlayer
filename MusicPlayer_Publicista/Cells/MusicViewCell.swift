//
//  MusicViewCell.swift
//  MusicPlayer_Publicista
//
//  Created by Fernanda de Lima on 20/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewCell: UITableViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBAction func playActionButton(_ sender: UIButton) {
        let url =  mm.response?.results![sender.tag].previewUrl
        iTunnesAPI.downloadFile(url: url!, name: "preview", success: { (path) in
            do {
                self.soundPlayer = try AVAudioPlayer(contentsOf: path)
                self.soundPlayer?.play()
            } catch {
                // couldn't load file :(
            }
        }) { (error, code) in
            print("--- error \(error?.localizedDescription ?? "sem descrição") ---- code\(code ?? 0)")
        }
        
    }
    
    @IBAction func downloadActionButton(_ sender: UIButton) {
        if IAPHandler.shared.canMakePurchases(){
            let alert = UIAlertController(title: "Sucesso", message: "Download iniciado", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "pay wall", message: "Pague o aluguel, rs", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    var soundPlayer: AVAudioPlayer?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
