//
//  UpdateViewController.swift
//  Firebase Demo
//
//  Created by Christopher Ching on 2018-04-23.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase

class UpdateViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var dbRef:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        
        if textField.text == nil || textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            // If textfield is empty, then don't continue
            return
        }
        
        var updates = ["employees/Mike/likes":textField.text!, "employees/Sandra/likes":textField.text! ]
        
        dbRef?.updateChildValues(updates)
        
    }
    

}
