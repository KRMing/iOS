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
        getLocalJsonFile()
    }
    
    func getLocalJsonFile() {
        
        // get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: ".json")
        
        guard path != nil else {
            print("Couldn't find the json data file")
            return
        }
        
        // create URL object from the path
        let url = URL(fileURLWithPath: path!)
        
        // get the data from the URL
        do {
            
            let data = try Data(contentsOf: url)
            
            // try to decode the data into objects
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // notify the delegate of the retrieved questions
            delegate?.questionsRetrieved(array)
        }
        catch {
            
            print("error! either decoder was nil or something happened trying to decode data")
        }
        
        
        
        
    }
    
    func getRemoteJsonFile() {
        
        
        
    }
}
