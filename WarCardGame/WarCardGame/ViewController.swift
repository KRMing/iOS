//
//  ViewController.swift
//  WarCardGame
//
//  Created by Christopher Ching on 2019-02-21.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftScoreLabel: UILabel!
    
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func dealTapped(_ sender: Any) {
        
        print("Deal Tapped!")
        
    }
    

}

