//
//  ScrollingNewsCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 26/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class ScrollingNewsCell: UICollectionViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    func updateUI(scrollingNews: LatestNews) {
        self.headlineLabel.text = scrollingNews.headline
    }
}
