//
//  AnotherNewsVC.swift
//  Khabar7
//
//  Created by Aman Chawla on 06/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit

class AnotherNewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var SuggestedLatestNews = [LatestNews]()
    var SuggestedProgramNews = [ProgramNews]()
    
    var latestNews = [LatestNews]()
    var programNews = [ProgramNews]()
    
    var transferLatest = [LatestNews]()
    var transferProgram = [ProgramNews]()
    
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
        
        if SuggestedLatestNews.isEmpty == false {
            return (SuggestedLatestNews.count + 4)
        } else if SuggestedProgramNews.isEmpty == false {
            return (SuggestedProgramNews.count + 4)
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherArticleCell", for: indexPath) as? AnotherArticleCell {
                
                if latestNews.isEmpty == true {
                    let program = programNews[indexPath.row]
                    cell.updateUI2(program: program)
                } else if programNews.isEmpty == true {
                    let latest = latestNews[indexPath.row]
                    cell.updateUI(latest: latest)
                }
                
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FirstLabelCell") {
                
                return cell
            }
        } else if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherSubmissionCell", for: indexPath) as? AnotherSubmissionCell {
                
                return cell
            }
        } else if indexPath.row == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLabelCell") {
                
                return cell
            }
        } else if indexPath.row >= 4 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherSuggestionCell", for: indexPath) as? AnotherSuggestionCell {
                
                if SuggestedLatestNews.isEmpty == false {
                    let latest = SuggestedLatestNews[indexPath.row - 4]
                    cell.updateUI(latest: latest)
                } else if SuggestedProgramNews.isEmpty == false {
                    let program = SuggestedProgramNews[indexPath.row - 4]
                    cell.updateUI2(program: program)
                } else {
                    return UITableViewCell()
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= 4 {
            return 120
        }
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 4 {
            if let cell = tableView.cellForRow(at: indexPath) as? AnotherSuggestionCell {
                if SuggestedLatestNews.isEmpty == false {
                    self.transferLatest = cell.transferLatest
                    performSegue(withIdentifier: "NewsVC", sender: self)
                } else if SuggestedProgramNews.isEmpty == false {
                    self.transferProgram = cell.transferProgram
                    performSegue(withIdentifier: "NewsVC", sender: self)
                }
            }
        }
    }

    //MARK -- util
    
    //back button
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsVC" {
            if let destination = segue.destination as? NewsVC  {
                if SuggestedLatestNews.isEmpty == false {
                    destination.latestNews = self.transferLatest
                    destination.SuggestedLatestNews = self.SuggestedLatestNews
                } else if SuggestedProgramNews.isEmpty == false {
                    destination.programNews = self.transferProgram
                    destination.SuggestedProgramNews = self.SuggestedProgramNews
                }
            }
        }
    }
    
}
