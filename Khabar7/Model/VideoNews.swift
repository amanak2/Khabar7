//
//  VideoNews.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import Foundation

class VideoNews {
    
    private var _video_url: String!
    private var _app_img: String!
    
    var videoNews: VideoNews!
    var videoN = [VideoNews]()
    
    var video_url: String {
        if _video_url == nil {
            _video_url = ""
        }
        return _video_url
    }
    
    var app_img: String {
        if _app_img == nil {
            _app_img = ""
        }
        return _app_img
    }
    
    init(getVideo: [String: Any]) {
        
        if let video_url = getVideo["video_url"] as? String {
            self._video_url = video_url
        }
        
        if let app_img = getVideo["app_img"] as? String {
            self._app_img = app_img
        }
        
    }
}
