//
//  QuizFormat.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class QuizFormat: Codable {
    
    var question: String
    var answers: [String]
    var correctAnswerIndex: Int
    var feedback: String
    
    init(question: String = "", answers: [String] = [String](), correctAnswerIndex: Int = 0, feedback: String = "") {
        
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        self.feedback = feedback
    }
}
