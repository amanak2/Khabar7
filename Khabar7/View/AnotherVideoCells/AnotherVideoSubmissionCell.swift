//
//  AnotherVideoSubmissionCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 10/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit

class AnotherVideoSubmissionCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var submissionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func submissionBtnPressed(_ sender: Any) {
    }

}
