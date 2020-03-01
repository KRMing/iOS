//
//  ViewController.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class BaseScreenVC: UIViewController, QuizModelDelegate {
    
    var quizModel = QuizModel()
    var quizData: [QuizFormat]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        quizModel.quizModelDelegate = self
    }
    
    // MARK: - Quiz Model Delegate Protocol

    func fetchQuizElements(elementArray: [QuizFormat]) {
        
        quizData = elementArray
        
        print(quizData)
    }
}

