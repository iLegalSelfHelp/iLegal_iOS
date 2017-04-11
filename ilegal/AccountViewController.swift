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
    
    private var userProperties = [UserProperty]()
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 111.0/255.0, green: 42.0/255.0, blue: 59.0/255.0, alpha:1.0)
        
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background2.png"));
    
        
        
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 113.0/255.0, green: 158.0/255.0, blue: 255.0/255.0, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? userProperties.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = indexPath.section == 0 ? "userPropertyCell" : "logoutCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.4);

        
        if indexPath.section == 0 {
            (cell as! UserPropertyCell).userProperty = userProperties[indexPath.row]
        }

        return cell
    }
    
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            Backend.clearUserLocal()
        } else if segue.identifier == "updateUserSegue" {
            let indexPath = tableView.indexPathForSelectedRow
            (segue.destination as! UpdateUserViewController).userProperty = userProperties[indexPath!.row]
        }
     }

    // MARK: - Methods
    
    private func reloadData() {
        userProperties = [
            UserProperty(displayName: "First Name", value: User.currentUser.firstName, sqlName: "FirstName"),
            UserProperty(displayName: "Last Name", value: User.currentUser.lastName, sqlName: "LastName"),
            UserProperty(displayName: "Email", value: User.currentUser.email, sqlName: "Email"),
            UserProperty(displayName: "Driver's License", value: User.currentUser.license, sqlName: "DLNumber"),
            UserProperty(displayName: "Address", value: User.currentUser.addressOne, sqlName: "Address1"),
            UserProperty(displayName: "City", value: User.currentUser.city, sqlName: "City"),
            UserProperty(displayName: "State", value: User.currentUser.state, sqlName: "State"),
            UserProperty(displayName: "Zip", value: User.currentUser.zipcode, sqlName: "ZipCode"),
        ]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
