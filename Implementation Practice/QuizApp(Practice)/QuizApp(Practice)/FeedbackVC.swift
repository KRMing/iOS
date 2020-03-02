//
//  FeedbackVC.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/2/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

protocol FeedbackDelegate {


}

class FeedbackVC: UIViewController {

    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var feedbackView: UIView!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    var delegate: FeedbackDelegate!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        feedbackView.layer.cornerRadius = 8
        feedbackView.layer.masksToBounds = true

        
    }
    
    @IBAction func didTouchFeedbackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
