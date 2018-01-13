//
//  OfflineNewsVC.swift
//  Khabar7
//
//  Created by Aman Chawla on 03/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit
import CoreData

class OfflineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [OfflineData]()
    var transfer = [OfflineData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fetchRequest: NSFetchRequest<OfflineData> = OfflineData.fetchRequest()
        
        do {
            let offline = try PersistentService.context.fetch(fetchRequest)
            self.news = offline
            tableView.reloadData()
        } catch { }
        
        if news.isEmpty == true {
            let alert = UIAlertController(title: "No Offline News", message: "Please Add News to Read From Offline", preferredStyle: .alert)
            
            let okBtn = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                    self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(okBtn)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK -- TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfflineCell", for: indexPath) as? OfflineCell {
            
            let news = self.news[indexPath.row]
            cell.updateUI(news: news)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? OfflineCell {
            self.transfer = cell.transfer
            performSegue(withIdentifier: "OfflineNewsVC", sender: self)
        }
    }
    
    //MARK -- util
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OfflineNewsVC" {
            if let destination = segue.destination as? OfflineNewsVC {
                destination.transfer = self.transfer
            }
        }
    }

}
