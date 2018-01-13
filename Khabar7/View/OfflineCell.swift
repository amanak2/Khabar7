//
//  OfflineCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 03/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit

class OfflineCell: UITableViewCell {
    
    @IBOutlet weak var headlineTextView: UITextView!
    
    var transfer = [OfflineData]()
    
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
        self.transfer.removeAll()
        self.transfer.append(news)
    }
}
