//
//  QuizModel.swift
//  QuizApp
//
//  Created by 이민건 on 2/26/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    
    func questionsRetrieved(_ questions: [Question])
}

class QuizModel {
    
    var delegate: QuizProtocol?
    
    func getQuestions() {
        
        // TODO: fetch the questions
        
        // notify the delegate of the retrieved questions
        delegate?.questionsRetrieved([Question]())
    }
}
