//
//  QuizModel.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

protocol QuizModelDelegate {
    
    func assignDataToDelegate(elementArray: [QuizFormat])
}

class QuizModel {
    
    var delegate: QuizModelDelegate!
    
    let fileName = "QuestionData"
    
    enum sourceType {
        
        case local
        case remote
    }
    
    func loadData(type: sourceType) {
        
        switch type {
            
            case .local:
            fetchLocalJsonData()
            case .remote:
            fetchRemoteJsonData()
        }
    }
    
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
            
            DispatchQueue.main.async {
                
                self.delegate.assignDataToDelegate(elementArray: array!)
            }
        }
        catch {
            
            print("couldn't assign data from url: \(url)")
            return
        }
    }
    
    func fetchRemoteJsonData() {
            
        let urlString = "https://raw.githubusercontent.com/KRMing/iOS/master/Implementation%20Practice/QuizApp(Practice)/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            
            print("url could not be retreived!")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let array = try decoder.decode([QuizFormat].self, from: data!)
                    
                    DispatchQueue.main.async {
                        
                        self.delegate.assignDataToDelegate(elementArray: array)
                    }
                }
                catch {
                    
                    print("couldn't parse JSON")
                    return
                }
            }
        }
        
        dataTask.resume()
    }
}
