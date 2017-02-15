//
//  UpdateUserViewController.swift
//  ilegal
//
//  Created by Matthew Rigdon on 2/14/17.
//  Copyright © 2017 Jordan. All rights reserved.
//

import UIKit

class UpdateUserViewController2: UIViewController {
    
    var fieldToChange = ""
    var oldValue = ""
    
    // MARK: - Outlets

    @IBOutlet weak var oldValueLabel: UILabel!
    @IBOutlet weak var newValueTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func tappedSubmit(_ sender: Any) {
        Backend.updateUser(fieldToChange: fieldToChange, withNewValue: newValueTextField.text ?? "") { error in
            if let error = error {
                print(error)
            } else {
                print("success")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = fieldToChange
        oldValueLabel.numberOfLines = 0
        oldValueLabel.sizeToFit()
        oldValueLabel.text = oldValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
