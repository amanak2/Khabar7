//
//  VideoArticleCell.swift
//  Khabar7
//
//  Created by Aman Chawla on 27/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class VideoArticleCell: UITableViewCell {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var headlineTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(video: VideoNews) {
        headlineTextView.text = "Video"
        
        webView.allowsInlineMediaPlayback = true
        
        let URL = "https://www.youtube.com/embed/\(video.video_url)"
        
        webView.loadHTMLString("<iframe width=\"\(webView.frame.width)\" height=\"\(webView.frame.height)\" src=\"\(URL)/&playsinline=1\" frameborder=\"0\" gesture=\"media\" allow=\"encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
    }

}
