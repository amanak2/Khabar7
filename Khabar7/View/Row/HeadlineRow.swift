//
//  HeadlineRow.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class HeadlineRow: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, OfflineButten {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate:HeadlineToNews? = nil
    weak var del: OfflineTransfer? = nil

    var latest = [LatestNews]()
    var transferData = [LatestNews]()
    var transferOfflineData = [LatestNews]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlineCell", for: indexPath) as? HeadlineCell {
            
            let latest = self.latest[indexPath.row]
            cell.updateUI(latest: latest)
            cell.delegate = self
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HeadlineCell {
            self.transferData.removeAll()
            self.transferData = cell.transferData
            delegate?.pushToNewsVC(latestNews: self.transferData)
        }
    }
    
    func AddToOffline(transferData: [LatestNews]) {
        transferOfflineData.removeAll()
        self.transferOfflineData = transferData
        del?.transferOfflineData(news: transferOfflineData)
    }
    
}
