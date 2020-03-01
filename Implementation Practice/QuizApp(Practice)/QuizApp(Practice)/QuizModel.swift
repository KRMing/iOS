//
//  QuizModel.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

protocol QuizModelDelegate {
    
    func fetchQuizElements(elementArray: [QuizFormat])
}

class QuizModel {
    
    var quizModelDelegate: QuizModelDelegate!
    
    let fileName = "QuestionData"
    
    func fetchLocalJsonData() {
    
        let array: [QuizFormat]?
        
        let path = Bundle.main.path(forResource: self.fileName, ofType: "json")
        
        guard path != nil else {
                
            print("couldn't allocate path for \(self.fileName).json")
            return
        }
        
        let url = URL(fileURLWithPath: path!)
        
        do {
            
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            array = try decoder.decode([QuizFormat].self, from: data)
            
            guard array != nil else {
                
                print("couldn't assign array from decoder")
                return
            }
            
            quizModelDelegate.fetchQuizElements(elementArray: array!)
        }
        catch {
            
            print("couldn't assign data from url: \(url)")
            return
        }
    }
    
    func fetchRemoteJsonData() {
            
        
    }
}
