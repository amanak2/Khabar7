//
//  OfflineNewsCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 03/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit
import SDWebImage

class OfflineNewsCell: UITableViewCell {

    @IBOutlet weak var headlineTextView: UITextView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var storyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(news: OfflineData){
        self.headlineTextView.text = news.headline
        self.thumbnail.sd_setImage(with: URL(string: "\(news.app_img ?? "")"))
        self.storyTextView.text = news.story?.html2String
    }

}
