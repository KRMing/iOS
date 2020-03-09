//
//  WriteViewController.swift
//  Firebase Demo
//
//  Created by Christopher Ching on 2018-04-23.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase

class WriteViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var dbRef:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Getting the database reference
        dbRef = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if textField.text == nil || textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            // If textfield is empty, then don't continue
            return
        }
        
        
        // Add the employee to the database
        var employeeData:[String : Any] = ["age":23, "likes":"ice cream", "role":"admin"]
        
        dbRef?.child("employees").child(textField.text!).setValue(employeeData, withCompletionBlock: { (error, ref) in
            
            // Check if the write operation was successful
            if error == nil {
                // Write operation was successful
            }
            else {
                // Unsuccessful
            }
            
        })
        
        
    }
    
    

}
