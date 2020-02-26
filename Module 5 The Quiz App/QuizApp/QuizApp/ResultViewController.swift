//
//  ResultViewController.swift
//  QuizApp
//
//  Created by 이민건 on 2/26/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // now that the elements have loaded, set the text
        titleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
        
    }
    

    @IBAction func dismissTapped(_ sender: Any) {
        
        // TODO: dismiss the popup
        
    }
    

}
