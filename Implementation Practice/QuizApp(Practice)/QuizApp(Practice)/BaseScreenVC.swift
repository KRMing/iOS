//
//  ViewController.swift
//  QuizApp(Practice)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class BaseScreenVC: UIViewController {
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceTableView: UITableView!
    
    var quizModel = QuizModel()
    var quizData = [QuizFormat]()
    var quizIndex: Int = 0
    var numGotCorrect: Int = 0
    
    let animationSpeed: TimeInterval = 0.2
    
    var feedbackVC: FeedbackVC?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        quizModel.delegate = self
        quizModel.loadData(type: .local)
        
        choiceTableView.delegate = self
        choiceTableView.dataSource = self
        
        choiceTableView.estimatedRowHeight = 100
        choiceTableView.rowHeight = UITableView.automaticDimension
        choiceTableView.alwaysBounceVertical = false

        feedbackVC = storyboard?.instantiateViewController(identifier: "FeedbackVC") as? FeedbackVC
        feedbackVC?.delegate = self
    }
    
    // MARK: Modal Screen Presentation Style
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        viewControllerToPresent.modalPresentationStyle = .overCurrentContext
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    // MARK: - Game Display
    
    func loadQuestion() {
        
        toggleRootView(from: 0, to: 1, speed: animationSpeed)
        
        if quizIndex < quizData.count {
        
            let currentQuestion = quizData[quizIndex]
            
            questionLabel.text = currentQuestion.question
        }
        else {
            
            // index out of range
            questionLabel.text = ""
        }
    }
    
    func loadModalScreen(resultText: String, feedbackText: String, buttonText: String, delay: TimeInterval = 0.2) {
        
        toggleRootView(from: 1, to: 0, speed: 0)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            self.feedbackVC?.resultText = resultText
            self.feedbackVC?.feedbackText = feedbackText
            self.feedbackVC?.buttonText = buttonText
            self.feedbackVC?.animationSpeed = self.animationSpeed
            
            self.present(self.feedbackVC!, animated: true, completion: nil)
        }
    }
    
    // MARK: Custom Animations
    
    func toggleRootView(from: CGFloat, to: CGFloat, speed: TimeInterval = 0.8, delay: TimeInterval = 0) {
        
        if quizIndex < quizData.count - 1 {
            
            rootStackView.alpha = from
        }
        
        UIView.animate(withDuration: speed, delay: delay, options: .curveEaseOut, animations: {
            
            self.rootStackView.alpha = to
        }, completion: nil)
    }
}

extension BaseScreenVC: QuizModelDelegate {
    
    // MARK: - Quiz Model Delegate Protocol

    func assignDataToDelegate(elementArray: [QuizFormat]) {
        
        self.quizData = elementArray
        
        quizData.shuffle()
        loadQuestion()
        questionLabel.text = quizData[quizIndex].question
        choiceTableView.reloadData()
    }
}

extension BaseScreenVC: FeedbackDelegate {

    func feedbackButtonTapped() {
        
        if quizIndex < quizData.count - 1 {
            
            quizIndex += 1
            loadQuestion()
            choiceTableView.reloadData()
        }
        else {
            
            // present summary screen
            
            let percentage = Double(numGotCorrect) / Double(quizData.count)
            var summaryText: String
            
            if percentage == 1.0 {
                
                summaryText = "Excellent!\nPerfect Score!"
            }
            else if percentage >= 0.7 {
                
                summaryText = "You're definitely above average.\nKeep up the hard work!"
            }
            else if percentage >= 0.3 {
                
                summaryText = "Need more effort.\nPractice makes perfect!"
            }
            else {
                
                summaryText = "Try reviewing the materials.\nBetter luck next time!"
            }
            
            summaryText += "\n\n Got \(numGotCorrect) out of \(quizData.count) questions."
            
            loadModalScreen(resultText: "Summary", feedbackText: summaryText, buttonText: "Restart")
            
            quizData.shuffle()
            quizIndex = -1
            numGotCorrect = 0
        }
    }
}

extension BaseScreenVC: UITableViewDelegate, UITableViewDataSource {

    // MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if quizIndex < quizData.count {
            
            return quizData[quizIndex].answers.count
        }
        else {
            
            return 0
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
        
        let delay: TimeInterval = 0.0
        
        if currentQuestion.correctAnswerIndex == indexPath.row {

            numGotCorrect += 1
            
            loadModalScreen(resultText: "Correct!", feedbackText: currentQuestion.feedback, buttonText: "Ok!", delay: delay)
        }
        else {
            
            loadModalScreen(resultText: "Wrong!", feedbackText: currentQuestion.feedback, buttonText: "Got it!", delay: delay)
        }
    }
}
