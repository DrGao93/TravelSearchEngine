//
//  TableViewControllerFavorite.swift
//  
//
//  Created by 高家南 on 4/21/18.
//

import UIKit
import os.log

class TableViewControllerFavorite: UITableViewController {
    
    var rowsFav = [FavRow]()

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedRows = loadRows() {
            rowsFav = savedRows
            print(rowsFav)
        }else{
            rowsFav = [FavRow]()
        }
        
        
        //loadSampleRows()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func update(){
        print("updating fav")
        
        
        if let savedRows = loadRows() {
//            if savedRows.count == 0{
//                print("000000")
//                var label:UILabel
//                label = UILabel(frame: CGRect(x:0, y: 0, width: 150, height: 21))
//                label.center = CGPoint(x: 200, y: 585)
//                label.textColor = UIColor.white
//                label.font = UIFont.systemFont(ofSize: 10.0)
//                label.textAlignment = .center
//                label.text = "Keyword cannot be empty"
//                label.backgroundColor = UIColor.darkGray
//                label.tag = 101
//                parent?.view.addSubview(label)
//            }
            rowsFav = savedRows
            print(rowsFav)
        }else{
            rowsFav = [FavRow]()
        }
        self.tableview.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowsFav.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("table view")
        let cellIdentifier = "favoriteCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCellFavorite else{
            fatalError("The dequeued cell is not an instance of favoriteCell.")
        }
        
        let row = rowsFav[indexPath.row]
        print(row.name)
        cell.FavIcon.image = row.icon
        cell.FavName.text = row.name
        cell.FavAddress.text = row.address
        //print(row.name!)
        // Configure the cell... fill in image name and address!
        
        return cell
    }
    private func saveFavRows() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(rowsFav, toFile: FavRow.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("rows successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save rows...", log: OSLog.default, type: .error)
        }
    }
    private func loadRows() -> [FavRow]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: FavRow.ArchiveURL.path) as? [FavRow]
    }
    private func loadSampleRows() {

        //print("loadsamplerows")
        let imageUrl:URL = URL(string: "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png")!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        let image = UIImage(data: imageData as Data)
        guard let jpg = image else{
            fatalError("Unable to instantiate row1")
        }
        guard let row1 = FavRow(name: "Caprese Salad", icon:jpg, address: "address1") else {
            fatalError("Unable to instantiate row1")
        }




        rowsFav += [row1]
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction] {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {(action,index) in
            self.rowsFav.remove(at: indexPath.row)
            self.tableview.deleteRows(at: [indexPath], with: .fade)
            self.saveFavRows()
        }
        return [deleteAction]
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
