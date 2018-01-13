//
//  ProgramRow.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit

class ProgramRow: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate:ProgramToProgramVC? = nil
    
    var programNews: ProgramNews!
    var program = [ProgramNews]()
    var transferData = [ProgramNews]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return program.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramCell", for: indexPath) as? ProgramCell {
            
            let program = self.program[indexPath.row]
            cell.updateUI(program: program)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 120, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProgramCell {
            self.transferData.removeAll()
            self.transferData.append(cell.transferData.first!)
            delegate?.pushToProgramVC(programNews: transferData)
        }
    }

}
