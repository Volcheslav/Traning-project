//
//  TabVC.swift
//  Training Project
//
//  Created by VironIT on 8/4/22.
//

import UIKit

class TabVC: UITableViewController {

    private let picNameArray: [String] = ["big bang", "universe", "rocks",
                                          "the dark sun", "the sun", "Earth",
                                          "Moon", "Rocket", "sphinks", "spacex", "mars"]
    private var picAndTheirNamesArrTpls: [(String, UIImage)] {
        let arr = picNameArray.map { ($0, UIImage(named: $0) ?? UIImage(named: "bcgrng")!) }
        return arr
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .lightGray
        // self.tableView.backgroundColor = .darkGray
        // print(picAndTheirNamesArrTpls.map{$0.1})

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func showAlertText(textOnLabel: String) {
        let alert = UIAlertController(title: "Cell Info", message: textOnLabel, preferredStyle: .alert)
        alert.addCancelAction()
        self.present(alert, animated: true)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellText = tableView.cellForRow(at: indexPath)?.textLabel?.text
       // print("touch")
        showAlertText(textOnLabel: cellText ?? "no info")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return picNameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)
        // let cellImg : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        cell.textLabel?.text = picAndTheirNamesArrTpls[indexPath.row].0.capitalized
        cell.textLabel?.textColor = .white
        cell.imageView?.image = picAndTheirNamesArrTpls[indexPath.row].1
        // cell.addSubview(cellImg)
        cell.backgroundColor = .darkGray
        cell.selectionStyle = .blue

        return cell
    }
    // swiftlint:disable all
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
