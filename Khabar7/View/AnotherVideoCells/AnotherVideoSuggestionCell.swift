//
//  AnotherVideoSuggestionCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 10/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit

class AnotherVideoSuggestionCell: UITableViewCell {

    @IBOutlet weak var headlineTextField: UITextView!
    @IBOutlet weak var thumbnail: UIImageView!
    
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
        headlineTextField.text = "Video"
        self.thumbnail.sd_setImage(with: URL(string: "\(latest.app_img)"))
        self.transferVideo.removeAll()
        self.transferVideo.append(latest)
    }
    
}
