//
//  ViewController.swift
//  QuizApp
//
//  Created by 이민건 on 2/26/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    
    var resultDialog: ResultViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // initialize the result dialog
        resultDialog = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        
        // set self as the delegate and datasource for the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // hardcode for dynamic row heights
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        // set up the model
        model.delegate = self
        model.getQuestions()
    }

    func displayQuestion() {
        
        // check if there are questions and check that the currentQuestionIndex is not out of bounds
        guard questions.count > 0 && currentQuestionIndex < questions.count else {
            
            return
        }
        
        // display the question text
        questionLabel.text = questions[currentQuestionIndex].question
        
        // reload the answers table
        tableView.reloadData()
    }
    
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        
        // get a reference to the questions
        self.questions = questions
        
        // display the first question
        displayQuestion()
        
        // reload the tableview
        tableView.reloadData()
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard questions.count > 0 else {
            return 0
        }
        
        if let answers = questions[currentQuestionIndex].answers {
            return answers.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        // customize it
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil {
            
            let question = questions[currentQuestionIndex]
            
            if question.answers != nil && indexPath.row < question.answers!.count {
                
                // set the answer text for the label
                label!.text = question.answers![indexPath.row]
            }
        }
        
        // return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var titleText = ""
        
        // user has tapped on a row, check if it's the right answer
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex! == indexPath.row {
            
            // user got it right
            titleText = "Correct!"
            numCorrect += 1
        }
        else {
            
            // user got it wrong
            titleText = "Wrong!"
        }
        
        // show the popup
        if resultDialog != nil {
            
            // customize the dialog text
            resultDialog!.titleText = titleText
            resultDialog!.feedbackText = question.feedback!
            resultDialog!.buttonText = "Next"
            
            present(resultDialog!, animated: true, completion: nil)
        }
        
        // increment the currentQuestionIndex
        currentQuestionIndex += 1
        
        // display the next question
        displayQuestion()
    }
}
