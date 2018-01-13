//
//  NewsFromBreakingCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 27/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class NewsFromBreakingCell: UITableViewCell {

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

    func updateUI(latest: LatestNews){
        headlineTextView.text = latest.headline
        self.thumbnail.sd_setImage(with: URL(string: "\(latest.app_img)"))
        storyTextView.text = latest.story.html2String
    }
}
