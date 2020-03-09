//
//  UpdateViewController.swift
//  Firebase Demo
//
//  Created by 이민건 on 3/7/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit
import Firebase

class UpdateViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var dbRef: DatabaseReference?
    
    override func viewDidLoad() {

        super.viewDidLoad()

        dbRef = Database.database().reference()
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        
        var age = 0
        
        // if the user actually put something in the textfield, then try to convert it to an int
        if textField.text != nil && textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            
            age = Int(textField.text!) ?? 0
        }
        
        addAgeToMike(ageToAdd: age)
    }
    
    func addAgeToMike(ageToAdd: Int) {
        
        dbRef?.child("employees/Mike/age").runTransactionBlock({ (currentData) -> TransactionResult in
            
            // check if the current data is nil
            if let currentAge = currentData.value as? Int {
                
                // update the age
                let newAge = currentAge + ageToAdd
                
                // set it back to the currentData
                currentData.value = newAge
            }
            
            // return transaction result
            return TransactionResult.success(withValue: currentData)
        })
    }
    
    func updateLikes() {
        
        let likes = textField.text
                
                if likes == nil || likes!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    
                    print("wrong input")
                    return
                }
                
                dbRef?.child("employees/Tom/likes").setValue(likes!)
                dbRef?.child("employees/Sandra/likes").setValue(likes!)

        //        var updates = ["employees/Tom/role": "network asshole", "employees/Sandra/role": "human resources"]
                
        //        dbRef?.child("employees/Tom/role").setValue("network admin")
        //        dbRef?.updateChildValues(updates)
    }
}
