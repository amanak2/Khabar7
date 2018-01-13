//
//  NewsFromBreaking.swift
//  Khabar7
//
//  Created by Aman Chawla on 26/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class NewsFromBreakingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var transfer = [LatestNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK -- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFromBreakingCell", for: indexPath) as? NewsFromBreakingCell {
            
            let transfer = self.transfer[indexPath.row]
            cell.updateUI(latest: transfer)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    //MARK -- util
    
    //back button
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
