//
//  NewsSubmissionCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 27/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class NewsSubmissionCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ViewsTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func submiteBtnPressed(_ sender: Any) {
        
    }
    
}
