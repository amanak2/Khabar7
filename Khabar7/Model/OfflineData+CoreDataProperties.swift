//
//  OfflineData+CoreDataProperties.swift
//  Khabar7
//
//  Created by Aman Chawla on 04/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//
//

import Foundation
import CoreData


extension OfflineData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineData> {
        return NSFetchRequest<OfflineData>(entityName: "OfflineData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var link: Int64
    @NSManaged public var category: String?
    @NSManaged public var tag: String?
    @NSManaged public var headline: String?
    @NSManaged public var story: String?
    @NSManaged public var sub_story: String?
    @NSManaged public var video_url: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var onhomepage: String?
    @NSManaged public var edited_by: String?
    @NSManaged public var time: String?
    @NSManaged public var date: String?
    @NSManaged public var location: String?
    @NSManaged public var update: String?
    @NSManaged public var app_img: String?

}
