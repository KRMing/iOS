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
    
    var leftScore = 0
    var rightScore = 0
    
    var prevLeftRan:Int = 0
    var prevRightRan:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func dealTapped(_ sender: Any) {
        
        // randomize left number
        var leftNumber = Int.random(in: 2...14)
        while(leftNumber == prevLeftRan) { // change left number until it is not prev number
            leftNumber = Int.random(in: 2...14)
        }
        
        // randomize right number
        var rightNumber = Int.random(in: 2...14)
        while(rightNumber == leftNumber || rightNumber == prevRightRan) { // change right number until it is not prev number or left number
            rightNumber = Int.random(in: 2...14)
        }
        
        // display card images
        leftImageView.image = UIImage(named: "card\(leftNumber)")
        rightImageView.image = UIImage(named: "card\(rightNumber)")
        
        // calculate scores
        if(leftNumber > rightNumber) {
            leftScore += 1
            leftScoreLabel.text = String(leftScore)
        }
        else if (leftNumber < rightNumber) {
            rightScore += 1
            rightScoreLabel.text = String(rightScore)
        }
        
        prevLeftRan = leftNumber
        prevRightRan = rightNumber
    }
    

}

