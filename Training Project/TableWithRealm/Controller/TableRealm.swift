//
//  TableRealm.swift
//  Training Project
//
//  Created by VironIT on 8/15/22.
//

// swiftlint:disable all
import RealmSwift
import UIKit

class Man: Object {
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var university = ""
}



class TableRealm: UITableViewController {
    let realm = try! Realm()
    var items: Results<Man>!
    
  
    @IBAction func addMan(_ sender: UILongPressGestureRecognizer) {
        showSetNameAlert()
    }
    
    // @objc func addItem

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(Man.self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func showSetNameAlert() {
        let alert = UIAlertController(title: "Name", message: "Enter name and surname", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { $0.placeholder = "Name"})
        alert.addTextField(configurationHandler: { $0.placeholder = "Surname"})
        alert.addCancelAction()
        let okAction = UIAlertAction(title: "OK", style: .default) {[unowned self] _ in
            guard let textName = alert.textFields?.first?.text, let textSurname = alert.textFields?.last?.text, !textName.isEmpty, !textSurname.isEmpty else {
                return
            }
            
            let man = Man()
            man.name = textName
            man.surname = textSurname
            
            try! self.realm.write {
                self.realm.add(man)
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard items.isEmpty else {
            return 0
        }
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = "\(item.name) \(item.surname)"

        // Configure the cell...

        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// swiftlint:enable all
