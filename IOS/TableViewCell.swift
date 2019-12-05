//
//  TableViewCell.swift
//  hw9
//
//  Created by 高家南 on 4/17/18.
//  Copyright © 2018 me. All rights reserved.
//

import UIKit
import os.log
import Alamofire

class TableViewCell: UITableViewCell{

    
    @IBOutlet weak var favButton: UIButton!
    var rowsFav = [FavRow]()
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    var placeId: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }

    @IBAction func favButtonPressed(_ sender: Any) {
        
        if favButton.imageView?.image == #imageLiteral(resourceName: "favorite-empty"){
            print("empty")
            if let savedRows = loadRows() {
                print(savedRows.count)
                rowsFav = savedRows
            }else{
                rowsFav = [FavRow]()
            }
            let newRow = FavRow(name: name.text!, icon: icon.image!, address: address.text!)
            rowsFav.append(newRow!)
            
            saveFavRows()
            favButton.setImage(UIImage(named: "favorite-filled.png")!, for: [])
        }else{
            print("filled")
            if let savedRows = loadRows() {
                rowsFav = savedRows
                let index = findAtIndex(rows: rowsFav, name: self.name.text!)
                if  index != -1{
                    print("remove fav from table")
                    rowsFav.remove(at: index)
                    favButton.setImage(UIImage(named: "favorite-empty.png")!, for: [])
                    print(rowsFav.count)
                    saveFavRows()
                }
                favButton.setImage(UIImage(named: "favorite-empty.png")!, for: [])
            }

        }
        
       
       
        
    }
    func find(rows: [FavRow], name: String) -> Bool{
        for row in rows{
            if row.name == name {
                return true
            }
        }
        return false
    }
    func findAtIndex(rows: [FavRow], name: String) -> Int{
        for (index, row) in rows.enumerated(){
            if row.name == name {
                return index
            }
        }
        return -1
    }
    
    private func saveFavRows() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(rowsFav, toFile: FavRow.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("fav rows successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    private func loadRows() -> [FavRow]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: FavRow.ArchiveURL.path) as? [FavRow]
    }
    
}
