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
    
    var quotes = [Quote]()
    
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
        
        // If the user selected a row...
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
        
            // Set the quote property of the detail view controller
            destinationVC.quote = quotes[selectedIndexPath.row]
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // Fetch the data
        getData()
    }

    func getData() {
        
        // Challenge 1: Quotes with 15 or more likes
        // dbRef?.child("quotes").queryOrdered(byChild: "likes").queryStarting(atValue: 15)
        
        // Challenge 2: Quotes by Benjamin Franklin
        // dbRef?.child("quotes").queryOrdered(byChild: "author/name").queryEqual(toValue: "Benjamin Franklin")
        
        // Challenge 3: Quotes in the category Inspirational
        // dbRef?.child("quotes").queryOrdered(byChild: "type").queryEqual(toValue: "Inspirational")
        
        // Database call to get the quotes
        dbRef?.child("quotes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Get all the child snapshots and cast as DataSnapshot
            let snapshots = snapshot.children.allObjects as! [DataSnapshot]
            
            // Loop through each snapshot
            for snap in snapshots {
                
                // Get the dictionaries from snapshot value
                let quoteDict = snap.value as! [String:Any]
                let authorDict = quoteDict["author"] as! [String:String]
                
                // Get quote data into constants
                let quoteId = snap.key
                let title = quoteDict["title"] as? String
                let author = authorDict["name"]
                
                // Create quote
                let q = Quote(title: title, authorName: author, quoteId: quoteId)
                
                // Add quote to array
                self.quotes.append(q)
                
            }
            
            // Reload the tableview
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
        
        // Get labels
        let quoteLabel = cell.viewWithTag(1) as! UILabel
        let authorLabel = cell.viewWithTag(2) as! UILabel
        
        // Set labels
        quoteLabel.text = quotes[indexPath.row].title
        authorLabel.text = quotes[indexPath.row].authorName
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Trigger Segue
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
}
