//
//  ScoreResultVC.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ScoreResultVC: UIViewController {
    
    @IBOutlet weak var startScreenButton: UIButton!
    
    @IBOutlet weak var gameScreenButton: UIButton!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var userScoreView: UIView!
    
    @IBOutlet weak var userScoreLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var scores: [TimeInterval]?
    
    var userScore: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        titleView.layer.cornerRadius = 10
        titleView.layer.masksToBounds = true
        
        titleLabel.text = "Hall of Fame"
        
        userScoreView.layer.cornerRadius = 7
        userScoreView.layer.masksToBounds = true
        
        userScoreLabel.text = String(format: "Your Score: %.2f seconds", Double(userScore) / 1000.0)
        
        startScreenButton.layer.cornerRadius = 10
        startScreenButton.layer.masksToBounds = true
        
        startScreenButton.setTitle("Return", for: .normal)
        
        gameScreenButton.layer.cornerRadius = 10
        gameScreenButton.layer.masksToBounds = true
        
        gameScreenButton.setTitle("Restart", for: .normal)
    }
    
    @IBAction func startScreenButtonTapped(_ sender: Any) {
        
        let startScreenVC = storyboard?.instantiateViewController(identifier: "StartScreenVC") as! StartScreenVC
        
        self.present(startScreenVC, animated: true, completion: nil)
    }
    
    @IBAction func gameScreenButtonTapped(_ sender: Any) {
        
        let gameScreenVC = storyboard?.instantiateViewController(identifier: "GameScreenVC") as! GameScreenVC
        
        self.present(gameScreenVC, animated: true, completion: nil)
    }
}

extension ScoreResultVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if scores == nil {
            
            return 0
        }
        
        return scores!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        
        let label = cell?.viewWithTag(1) as? UILabel
        
        let view = cell?.viewWithTag(2)
        
        label?.text = String(format: "#\(indexPath.row + 1) : %.2f seconds", Double(scores![indexPath.row]) / 1000.0)
        
        view?.layer.cornerRadius = 7
        view?.layer.masksToBounds = true
        
        return cell!
    }
}
