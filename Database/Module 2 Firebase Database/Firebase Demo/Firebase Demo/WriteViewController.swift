//
//  WriteViewController.swift
//  Firebase Demo
//
//  Created by 이민건 on 3/7/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit
import Firebase

class WriteViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    // specifies the root node of the database
    var dbRef: DatabaseReference?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // getting the database reference
        dbRef = Database.database().reference()
    }
    

    @IBAction func addTapped(_ sender: Any) {
        
        if textField.text == nil || textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            print("nothing in the textfield")
            return
        }
        
        // add employee to the database
        let employeeData: [String: Any] = ["age": 23, "likes": "ice cream", "role": "admin", "name": textField.text!]
        
//        dbRef?.child("employee").child(textField.text!) or like this
        dbRef?.child("employees").childByAutoId().setValue(employeeData, withCompletionBlock: { (error, ref) in
            
            // check if the write operation was successful
            if error == nil {
                
                // write operation was successful
                
            }
            else {
                
                // unsuccessful
            }
        })
        
    }
    
}
