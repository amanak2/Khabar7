//
//  HeadlineCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit
import SDWebImage

class HeadlineCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var storyTextView: UITextView!
    
    var transferData = [LatestNews]()
    
    weak var delegate: OfflineButten? = nil
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }
    
    func updateUI(latest: LatestNews) {
        storyTextView.text = latest.headline
        self.thumbnail.sd_setImage(with: URL(string: "\(latest.app_img)"))
        self.transferData.removeAll()
        self.transferData.append(latest)
    }
    
    @IBAction func offlineBtnPressed(_ sender: UIButton) {
        delegate?.AddToOffline(transferData: transferData)
    }
    
}
