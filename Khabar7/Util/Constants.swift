//
//  Constants.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

//Constants
var baseURL = "http://khabar7.com/dashboard-insight/appfiles/news_sub_category/"
let SHADOW_GREY: CGFloat = 120.0 / 255.0 

//convert string to HTML
extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

//Protocol

protocol HeadlineToNews: class {
    func pushToNewsVC(latestNews: [LatestNews])
}

protocol PhotoToPhotoVC: class {
    func pushToPhotoVC(photoNews: [PhotoNews])
}

protocol VideoToVideoVC: class {
    func pushToVideoVC(videoNews: [VideoNews])
}

protocol ProgramToProgramVC: class {
    func pushToProgramVC(programNews: [ProgramNews])
}

protocol OfflineButten: class {
    func AddToOffline(transferData: [LatestNews])
}

protocol OfflineTransfer: class {
    func transferOfflineData(news: [LatestNews])
}

