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
    
    var animationSpeed: TimeInterval = 0.15
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.feedbackView.layer.cornerRadius = 10
        self.feedbackView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            
            self.backgroundView.alpha = 0
            self.resultLabel.alpha = 0
            self.feedbackLabel.alpha = 0
            self.feedbackButton.alpha = 0
            
            self.resultLabel.text = self.resultText
            self.feedbackLabel.text = self.feedbackText
            self.feedbackButton.setTitle(self.buttonText, for: .normal)
            
            print(self.feedbackText)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: animationSpeed, delay: 0, options: .curveEaseOut, animations: {
            
            self.backgroundView.alpha = 1
            self.resultLabel.alpha = 1
            self.feedbackLabel.alpha = 1
            self.feedbackButton.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func didTouchFeedbackButton(_ sender: Any) {
        
        UIView.animate(withDuration: animationSpeed, delay: 0, options: .curveEaseOut, animations: {
            
            self.backgroundView.alpha = 0
        }) { (_) in
            
            self.dismiss(animated: true, completion: nil)
            self.delegate.feedbackButtonTapped()
        }
    }
    
}
