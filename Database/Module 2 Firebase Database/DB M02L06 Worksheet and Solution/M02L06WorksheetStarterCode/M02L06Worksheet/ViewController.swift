//
//  ViewController.swift
//  M02L06Worksheet
//
//  Created by Christopher Ching on 2018-05-07.
//  Copyright © 2018 CodeWithChris. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // To store the quotes for the tableview
    var quotes = [Quote]()
    
    // Firebase database reference
    var dbRef:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tableview configuration
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Get database reference
        dbRef = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // When a segue happens, pass along the selected quote
        let destinationVC = segue.destination as! DetailViewController
        
        // TODO: Get selected quote
        let indexPath = self.tableView.indexPathForSelectedRow!
        
        // TODO: Pass selected quote to detail view controller
        destinationVC.quote = quotes[indexPath.row]
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // Fetch the data
        getData()
    }

    func getData() {
        
        // TODO: The database call to get the quotes
        dbRef?.child("quotes").observeSingleEvent(of: .value, with: { snapshot in
            
            let snapshots = snapshot.children.allObjects as! [DataSnapshot]
            
            self.quotes.removeAll()
            
            for snap in snapshots {

                let snapDict = snap.value as! [String: Any]
                
                let author = snapDict["author"] as! [String: String]
                
                self.quotes.append(Quote(title: snapDict["title"] as? String, authorName: author["name"]))
            }
            
            self.tableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        // TODO: Get labels
        let quote = cell.viewWithTag(1) as! UILabel
        let author = cell.viewWithTag(2) as! UILabel
        
        // TODO: Set labels
        quote.text = quotes[indexPath.row].title
        author.text = quotes[indexPath.row].authorName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TODO: Trigger Segue
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
}
