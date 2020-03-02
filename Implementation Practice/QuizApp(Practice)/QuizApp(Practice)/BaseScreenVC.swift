//
//  ViewController.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class BaseScreenVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceTableView: UITableView!
    
    var quizModel = QuizModel()
    var quizData: [QuizFormat]!
    var quizIndex: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        quizModel.delegate = self
        quizModel.loadData(type: .local)
        
        choiceTableView.delegate = self
        choiceTableView.dataSource = self
        
        questionLabel.text = quizData[quizIndex].question
    }
}

extension BaseScreenVC: QuizModelDelegate {
    
    // MARK: - Quiz Model Delegate Protocol

    func assignDataToDelegate(elementArray: [QuizFormat]) {
        
        self.quizData = elementArray
    }
}

extension BaseScreenVC: UITableViewDelegate, UITableViewDataSource {

    // MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if quizData.count == 0{
            
            return 0
        }
        else {
            
            return quizData[quizIndex].answers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let label = cell.viewWithTag(1) as? UILabel
    
        if label != nil {
            
            let currentQuestion = quizData[quizIndex]
            
            label!.text = currentQuestion.answers[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
    }
}
