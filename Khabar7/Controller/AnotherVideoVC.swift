//
//  AnotherVideoVC.swift
//  Khabar7
//
//  Created by Aman Chawla on 10/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit

class AnotherVideoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var SuggestedNews = [VideoNews]()
    var videoNews = [VideoNews]()
    
    var transferVideo = [VideoNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //MARK -- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (4 + SuggestedNews.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherVideoArticleCell", for: indexPath) as? AnotherVideoArticleCell {
                
                let video = self.videoNews[indexPath.row]
                cell.updateUI(video: video)
                
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FirstLabelCell") {
                
                return cell
            }
        } else if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherVideoSubmissionCell", for: indexPath) as? AnotherVideoSubmissionCell {
                
                return cell
            }
        } else if indexPath.row == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLabelCell") {
                
                return cell
            }
        } else if indexPath.row >= 4 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherVideoSuggestionCell", for: indexPath) as? AnotherVideoSuggestionCell {
                
                let latest = self.SuggestedNews[indexPath.row - 4]
                cell.updateUI(latest: latest)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= 4 {
            return 120
        }
        
        if indexPath.row == 0 {
            return 300
        }
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 4 {
            if let cell = tableView.cellForRow(at: indexPath) as? AnotherVideoSuggestionCell {
                self.transferVideo = cell.transferVideo
                performSegue(withIdentifier: "VideoVC", sender: self)
            }
        }
    }
    
    //MARK -- Util
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VideoVC" {
            if let destination = segue.destination as? VideoVC  {
                destination.videoNews = self.transferVideo
                destination.SuggestedNews = self.SuggestedNews
            }
        }
    }
    
    //back button
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
