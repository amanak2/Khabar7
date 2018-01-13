//
//  PhotoNews.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import Foundation

class PhotoNews {
    private var _id: Int!
    private var _link: Int!
    private var _category: String!
    private var _tag: String!
    private var _headline: String!
    private var _story: String!
    private var _sub_story: String!
    private var _video_url: String!
    private var _thumbnail: String!
    private var _onhomepage: String!
    private var _edited_by: String!
    private var _time: String!
    private var _date: String!
    private var _location: String!
    private var _update: String!
    private var _app_img: String!
    
    var photoNews: PhotoNews!
    var photo = [PhotoNews]()
    
    var id: Int {
        if _id == nil {
            _id = 0
        }
        return _id
    }
    
    var link: Int {
        if _link == nil {
            _link = 0
        }
        return _link
    }
    
    var category: String {
        if _category == nil {
            _category = ""
        }
        return _category
    }
    
    var tag: String {
        if _tag == nil {
            _tag = ""
        }
        return _tag
    }
    
    var headline: String {
        if _headline == nil {
            _headline = ""
        }
        return _headline
    }
    
    var story: String {
        if _story == nil {
            _story = ""
        }
        return _story
    }
    
    var sub_story: String {
        if _sub_story == nil {
            _sub_story = ""
        }
        return _sub_story
    }
    
    var video_url: String {
        if _video_url == nil {
            _video_url = ""
        }
        return _video_url
    }
    
    var thumbnail: String {
        if _thumbnail == nil {
            _thumbnail = ""
        }
        return _thumbnail
    }
    
    var onhomepage: String {
        if _onhomepage == nil {
            _onhomepage = ""
        }
        return _onhomepage
    }
    
    var edited_by: String {
        if _edited_by == nil {
            _edited_by = ""
        }
        return _edited_by
    }
    
    var time: String {
        if _time == nil {
            _time = ""
        }
        return _time
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    
    var location: String {
        if _location == nil {
            _location = ""
        }
        return _location
    }
    
    var update: String {
        if _update == nil {
            _update = ""
        }
        return _update
    }
    
    var app_img: String {
        if _app_img == nil {
            _app_img = ""
        }
        return _app_img
    }
    
    
    init(getPhoto: [String: Any]) {
        
        if let id = getPhoto["id"] as? Int {
            self._id = id
        }
        
        if let link = getPhoto["link"] as? Int {
            self._link = link
        }
        
        if let category = getPhoto["category"] as? String {
            self._category = category
        }
        
        if let tag = getPhoto["tag"] as? String {
            self._tag = tag
        }
        
        if let headline = getPhoto["headline"] as? String {
            self._headline = headline
        }
        
        if let story = getPhoto["story"] as? String {
            self._story = story
        }
        
        if let sub_story = getPhoto["sub_story"] as? String {
            self._sub_story = sub_story
        }
        
        if let video_url = getPhoto["video_url"] as? String {
            self._video_url = video_url
        }
        
        if let thumbnail = getPhoto["thumbnail"] as? String {
            self._thumbnail = thumbnail
        }
        
        if let onhomepage = getPhoto["onhomepage"] as? String {
            self._onhomepage = onhomepage
        }
        
        if let edited_by = getPhoto["edited_by"] as? String {
            self._edited_by = edited_by
        }
        
        if let time = getPhoto["time"] as? String {
            self._time = time
        }
        
        if let date = getPhoto["date"] as? String {
            self._date = date
        }
        
        if let location = getPhoto["location"] as? String {
            self._location = location
        }
        
        if let update = getPhoto["update"] as? String {
            self._update = update
        }
        
        if let app_img = getPhoto["app_img"] as? String {
            self._app_img = app_img
        }
    }
}
