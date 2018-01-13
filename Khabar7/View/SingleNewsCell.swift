//
//  SingleNewsCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class SingleNewsCell: UITableViewCell {

    @IBOutlet weak var headlineTextView: UITextView!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var SingleNewsTransfer = [LatestNews]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(singleNews: LatestNews) {
        headlineTextView.text = singleNews.headline
        self.thumbnail.sd_setImage(with: URL(string: "\(singleNews.app_img)"))
        self.SingleNewsTransfer.removeAll()
        self.SingleNewsTransfer.append(singleNews)
    }

}
