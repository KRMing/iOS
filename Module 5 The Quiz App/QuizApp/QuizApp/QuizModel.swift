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
//        getLocalJsonFile()
        getRemoteJsonFile()
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
        
        // get a URL object
//        let urlString = "https://codewithchris.com/code/QuestionData.json"
        let urlString = "https://raw.githubusercontent.com/KRMing/iOS/master/Module%205%20The%20Quiz%20App/QuizApp/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("couldn't create the url object")
            return
        }
        
        // get a URL session object
        let session = URLSession.shared
        
        // get a data task object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // check that there wasn't an error
            if error == nil && data != nil {
                
                do {
                    
                    // create a JSON Decoder object
                    let decoder = JSONDecoder()
                    
                    // Parse the JSON
                    let array = try decoder.decode([Question].self, from: data!)
                    
                    // use the main thread to notify the view controller for the UI work
                    DispatchQueue.main.async {
                        
                        // Notify the view controller
                        self.delegate?.questionsRetrieved(array)
                    }
                }
                catch {
                    print("couldn't parse JSON")
                    return
                }
            }
        }
        
        // call resume on the data task
        dataTask.resume()
    }
}
