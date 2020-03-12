//
//  ReadViewController.swift
//  Firebase Demo
//
//  Created by 이민건 on 3/9/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit
import Firebase

class ReadViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var employees = [Employee]()
    
    var dbRef: DatabaseReference?
    
    var databaseHandles = [UInt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        dbRef = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        listenForData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // close any observers open
        for handle in databaseHandles {
            
            dbRef?.removeObserver(withHandle: handle)
        }
    }
    
    func readDataOnce() {
        
        dbRef?.child("employees").observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
            
            // get all of the children objects of the snapshot
            let snapshots = snapshot.children.allObjects as! [DataSnapshot]
            
            self.employees.removeAll()
            
            // go through each child snapshot
            for snap in snapshots {
                
                // cast the snapshot value as a dictionary
                let employeeDict = snap.value as! [String: Any]
                
                // get the data for an employee
                let name = snap.key
                let age = employeeDict["age"] as! Int
                let likes = employeeDict["likes"] as! String
                let role = employeeDict["role"] as! String
                
                // create an employee
                let e = Employee(name: name, age: age, likes: likes, role: role)
                
                // add him/her to the array
                self.employees.append(e)
            }
            
            self.tableView.reloadData()
        })
    }
    
    func listenForData() {
        
        let handle = dbRef?.child("employees").queryOrdered(byChild: "age").queryStarting(atValue: 10).queryEnding(atValue: 30).observe(.value, with: { (snapshot) in
            
            // get all of the children objects of the snapshot
            let snapshots = snapshot.children.allObjects as! [DataSnapshot]
            
            self.employees.removeAll()
            
            // go through each child snapshot
            for snap in snapshots {
                
                // cast the snapshot value as a dictionary
                let employeeDict = snap.value as! [String: Any]
                
                // get the data for an employee
                let name = snap.key
                let age = employeeDict["age"] as! Int
                let likes = employeeDict["likes"] as! String
                let role = employeeDict["role"] as! String
                
                // create an employee
                let e = Employee(name: name, age: age, likes: likes, role: role)
                
                // add him/her to the array
                self.employees.append(e)
            }
            
            self.tableView.reloadData()
        })
        
        // check if the handle is nil, if not, then save it
        if handle != nil {
            
            databaseHandles.append(handle!)
        }
    }
}

extension ReadViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        
        // set the labels for the cell
        let nameLabel = cell.viewWithTag(1) as! UILabel
        let roleLabel = cell.viewWithTag(2) as! UILabel
        
        nameLabel.text = employees[indexPath.row].name
        roleLabel.text = employees[indexPath.row].role
        
        return cell
    }
    
}
