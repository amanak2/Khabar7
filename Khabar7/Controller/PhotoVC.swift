//
//  ImageVC.swift
//  Khabar7
//
//  Created by Aman Chawla on 26/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var photoNews = [PhotoNews]()
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFromPhotoCell", for: indexPath) as? NewsFromPhotoCell {
            
            let photo = self.photoNews[indexPath.row]
            cell.updateUI(photo: photo)
            
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
