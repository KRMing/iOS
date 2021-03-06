//
//  ResultViewController.swift
//  QuizApp
//
//  Created by 이민건 on 2/26/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

protocol ResultViewControllerProtocol {
    
    func dialogDismissed()
}

class ResultViewController: UIViewController {

    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    var delegate: ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // round the dialog box corners
        dialogView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // now that the elements have loaded, set the text
        titleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
        
        // hide the UI elements
        dimView.alpha = 0
        titleLabel.alpha = 0
        feedbackLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //fade in the elements
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            
            self.dimView.alpha = 1
            self.titleLabel.alpha = 1
            self.feedbackLabel.alpha = 1
        }, completion: nil)
    }

    @IBAction func dismissTapped(_ sender: Any) {
        
        // fade out the dim view and then dismiss the popup
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            
            self.dimView.alpha = 0
        }) { (completed) in
            
            // TODO: dismiss the popup
            self.dismiss(animated: true, completion: nil)
            
            // notify delegate the popup was dismissed
            self.delegate?.dialogDismissed()
        }
    }
}
