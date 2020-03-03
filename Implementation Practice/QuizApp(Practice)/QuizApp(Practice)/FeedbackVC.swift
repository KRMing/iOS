//
//  FeedbackVC.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/2/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

protocol FeedbackDelegate {

    func feedbackButtonTapped ()
}

class FeedbackVC: UIViewController {

    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var feedbackView: UIView!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    var delegate: FeedbackDelegate!
    
    var resultText: String = ""
    var feedbackText: String = ""
    var buttonText: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            
            self.feedbackView.layer.cornerRadius = 8
            self.feedbackView.layer.masksToBounds = true
            
            self.resultLabel.text = self.resultText
            self.feedbackLabel.text = self.feedbackText
            self.feedbackButton.setTitle(self.buttonText, for: .normal)
        }
    }
    
    @IBAction func didTouchFeedbackButton(_ sender: Any) {
        
        delegate.feedbackButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
}
