//
//  VideoSuggestionCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 27/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class VideoSuggestionCell: UITableViewCell {

    @IBOutlet weak var headlineTextView: UITextView!
    @IBOutlet weak var thumnail: UIImageView!
    
    var transferVideo = [VideoNews]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(latest: VideoNews){
        headlineTextView.text = "Video"
        self.thumnail.sd_setImage(with: URL(string: "\(latest.app_img)"))
        self.transferVideo.removeAll()
        self.transferVideo.append(latest)
    }

}
