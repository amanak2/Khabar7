//
//  ProgramCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class ProgramCell: UICollectionViewCell {
   
    @IBOutlet weak var thumbnail: UIImageView!
    
    var transferData = [ProgramNews]()
    
    override func awakeFromNib() {
        contentView.layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        contentView.layer.shadowOpacity = 0.9
        contentView.layer.shadowRadius = 6.0
        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        contentView.layer.cornerRadius = 2.0
    }
    
    func updateUI(program: ProgramNews){
        self.thumbnail.sd_setImage(with: URL(string: "\(program.app_img)"))
        self.transferData.removeAll()
        self.transferData.append(program)
    }
}
