//
//  ViewController.swift
//  QuizApp
//
//  Created by 이민건 on 2/26/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.delegate = self
        model.getQuestions()
    }

    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        
        print("questions retrieved from model!")
        
    }

}

