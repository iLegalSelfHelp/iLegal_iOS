//
//  AccountViewController.swift
//  ilegal
//
//  Created by Matthew Rigdon on 2/7/17.
//  Copyright © 2017 Jordan. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var userProperties = [(String, String)]()
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 113.0/255.0, green: 158.0/255.0, blue: 255.0/255.0, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        userProperties = [
            ("Name", User.currentUser.fullName),
            ("Email", User.currentUser.email),
            ("Address", User.currentUser.addressOne),
            ("Password", "●●●●●●●●")
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? userProperties.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = indexPath.section == 0 ? "userPropertyCell" : indexPath.section == 1 ? "contactUsCell" : "logoutCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        
        if indexPath.section == 0 {
            (cell as! UserPropertyCell).keyLabel.text = userProperties[indexPath.row].0
            (cell as! UserPropertyCell).valueLabel.text = userProperties[indexPath.row].1
        }

        return cell
    }
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            Backend.clearUserLocal()
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

}
