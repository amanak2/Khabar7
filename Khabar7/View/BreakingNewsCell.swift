//
//  BreakingNewsCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 27/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class BreakingNewsCell: UITableViewCell {

    @IBOutlet weak var headlineTextView: UITextView!
    
    var transfer = [LatestNews]()
    
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
        self.transfer.removeAll()
        self.transfer.append(latest)
    }

}
