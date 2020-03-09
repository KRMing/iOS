//
//  DeleteViewController.swift
//  Firebase Demo
//
//  Created by 이민건 on 3/7/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit
import Firebase

class DeleteViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var dbRef: DatabaseReference?
    
    override func viewDidLoad() {

        super.viewDidLoad()

        dbRef = Database.database().reference()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
        let name = textField.text
        
        if name == nil || name!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            print("wrong input")
            return
        }
        
        dbRef?.child("employees").child(name!).removeValue()
        
//        dbRef?.child("employees/Tom").setValue(nil)
//        dbRef?.child("employees/Tom").removeValue()
    }
}
