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
    }

    @IBAction func dismissTapped(_ sender: Any) {
        
        // TODO: dismiss the popup
        self.dismiss(animated: true, completion: nil)
        
        // notify delegate the popup was dismissed
        delegate?.dialogDismissed()
    }
}
