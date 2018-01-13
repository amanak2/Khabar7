//
//  BreakingNewsVC.swift
//  Khabar7
//
//  Created by Aman Chawla on 26/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit
import Alamofire

class BreakingNewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [LatestNews]()
    var transfer = [LatestNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    //MARK -- Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BreakingNewsCell", for: indexPath) as? BreakingNewsCell {
            
            let news = self.news[indexPath.row]
            cell.updateUI(latest: news)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastItem = news.count - 1
        
        if indexPath.row == lastItem {
            let lastCategory = news.last?.category
            
            Alamofire.request("\(baseURL)news.php?category=crime+\(lastCategory!)").responseJSON { response in
                if let dict = response.result.value as? [[String: Any]] {
                    for obj in dict {
                        let news = LatestNews(getLatest: obj)
                        self.news.append(news)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? BreakingNewsCell {
            self.transfer = cell.transfer
            performSegue(withIdentifier: "NewsFromBreakingVC", sender: self)
        }
    }
    
    //MARK -- util
    
    //back button
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsFromBreakingVC" {
            if let destination = segue.destination as? NewsFromBreakingVC {
                destination.transfer = self.transfer
            }
        }
    }
    
    func getData() {
        Alamofire.request("\(baseURL)news.php?category=crime").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let news = LatestNews(getLatest: obj)
                    self.news.append(news)
                }
            }
            self.tableView.reloadData()
        }
    }

}
