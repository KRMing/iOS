//
//  ArticleModel.swift
//  NewsApp
//
//  Created by 이민건 on 3/4/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrieved(_ articles: [Article])
}

class ArticleModel {
    
    var delegate: ArticleModelProtocol?
    
    static let apiKey: String = "362e84596e4144fd8007ad4a56b95d8a"
    
    func getArticles() {
        
        // fire off the request to the API
        
        // create a string URL
        
        let urlString = "http://newsapi.org/v2/everything?q=bitcoin&from=2020-02-04&sortBy=publishedAt&apiKey=" + ArticleModel.apiKey
        
        // create a URL object
        let url = URL(string: urlString)
        
        // check that it isn't nill
        guard url != nil else {
            
            print("couldn't get URL from URL string.")
            return
        }
        
        // get the URL session
        let urlSession = URLSession.shared
        
        // create the data task
        let dataTask = urlSession.dataTask(with: url!) { (data, response, error) in
            
            if data != nil && error == nil {
                
                // attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    // parse the json into ArticleService
                    let articlesService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // get the articles
                    let articles = articlesService.articles!
                    
                    // pass it back to the view controller
                    DispatchQueue.main.async {
                            
                        // parse the returned JSOn into article instances and pass it back to the view controller with the protocol and delegate pattern
                        self.delegate?.articlesRetrieved(articles)
                    }
                }
                catch {
                    
                    print("failed to parse JSON.")
                    return
                }
            }
        }
        
        // start the data task
        dataTask.resume()
    }
}
