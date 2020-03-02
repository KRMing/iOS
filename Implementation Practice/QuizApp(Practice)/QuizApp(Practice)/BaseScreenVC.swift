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
    
    var feedbackVC: FeedbackVC?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        quizModel.delegate = self
        quizModel.loadData(type: .local)
        
        choiceTableView.delegate = self
        choiceTableView.dataSource = self
        
        choiceTableView.estimatedRowHeight = 100
        choiceTableView.rowHeight = UITableView.automaticDimension

        questionLabel.text = quizData[quizIndex].question
        
        feedbackVC = storyboard?.instantiateViewController(identifier: "FeedbackVC") as? FeedbackVC
        feedbackVC?.modalPresentationStyle = .overCurrentContext

        feedbackVC?.delegate = self
        
        
    }
}

extension BaseScreenVC: QuizModelDelegate {
    
    // MARK: - Quiz Model Delegate Protocol

    func assignDataToDelegate(elementArray: [QuizFormat]) {
        
        self.quizData = elementArray
    }
}

extension BaseScreenVC: FeedbackDelegate {


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
        
        let view = cell.viewWithTag(2)
        
        view?.layer.cornerRadius = 5
        view?.layer.masksToBounds = true
    
        if label != nil {
            
            let currentQuestion = quizData[quizIndex]
            
            label!.text = currentQuestion.answers[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentQuestion = quizData[quizIndex]
        
        if currentQuestion.correctAnswerIndex == indexPath.row {
            
            feedbackVC?.resultLabel.text = "Correct!"
        }
        else {
            
            feedbackVC?.resultLabel.text = "Wrong!"
        }
        
        let delay: TimeInterval = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            // use perform seque, prepare(for segue:)
//            self.performSegue(withIdentifier: "BaseToFeedback", sender: self)
            
            self.present(self.feedbackVC!, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
    }
    
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        viewControllerToPresent.modalPresentationStyle = .overCurrentContext
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
