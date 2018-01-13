//
//  NewsSuggestionCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 27/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class NewsSuggestionCell: UITableViewCell {

    @IBOutlet weak var headlineTextView: UITextView!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var transferLatest = [LatestNews]()
    var transferProgram = [ProgramNews]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(latest: LatestNews){
        self.headlineTextView.text = latest.headline
        self.thumbnail.sd_setImage(with: URL(string: "\(latest.app_img)"))
        self.transferLatest.removeAll()
        self.transferLatest.append(latest)
    }
    
    func updateUI2(program: ProgramNews){
        self.headlineTextView.text = program.headline
        self.thumbnail.sd_setImage(with: URL(string: "\(program.app_img)"))
        self.transferProgram.removeAll()
        self.transferProgram.append(program)
    }

}
