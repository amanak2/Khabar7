//
//  NewsFromSingleCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 27/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class NewsFromSingleCell: UITableViewCell {

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

    func updateUI(mainNews: LatestNews){
        headlineTextView.text = mainNews.headline
        self.thumbnail.sd_setImage(with: URL(string: "\(mainNews.app_img)"))
        storyTextView.text = mainNews.story.html2String
    }
}
