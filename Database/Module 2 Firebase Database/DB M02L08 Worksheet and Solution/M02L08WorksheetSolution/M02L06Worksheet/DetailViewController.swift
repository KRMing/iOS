//
//  DetailViewController.swift
//  M02L06Worksheet
//
//  Created by Christopher Ching on 2018-05-07.
//  Copyright © 2018 CodeWithChris. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!

    var dbRef:DatabaseReference?
    
    var quote:Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get database reference
        dbRef = Database.database().reference()

        // If there's a quote, set the labels
        if quote != nil {
            
            quoteLabel.text = quote!.title
            authorLabel.text = quote!.authorName
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
        
        // Make sure quote property isn't nil
        guard quote != nil else {
            return
        }
        
        // Run transaction block to update the likes count
        
        dbRef?.child("quotes").child(quote!.quoteId!).child("likes").runTransactionBlock({ (currentData) -> TransactionResult in
            
            // Make sure that it isn't nil
            if let likesCount = currentData.value as? Int {
                
                // Increment the count
                let newLikesCount = likesCount + 1
                
                // Set it back to the mutable data
                currentData.value = newLikesCount
                
                // Return success
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        })
        
    }
    
    

}
