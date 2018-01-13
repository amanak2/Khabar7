//
//  OfflineNewsDisplayVC.swift
//  Khabar7
//
//  Created by Aman Chawla on 03/01/18.
//  Copyright © 2018 Aman Chawla. All rights reserved.
//

import UIKit

class OfflineNewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var transfer = [OfflineData]()
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfflineNewsCell", for: indexPath) as? OfflineNewsCell {
            
            let news = self.transfer[indexPath.row]
            cell.updateUI(news: news)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    //MARK -- Util
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
