//
//  MainViewController.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class StartScreenVC: UIViewController {
        
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 8
        startButton.widthAnchor.constraint(equalToConstant: 608).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 84).isActive = true
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        
        let gameScreenVC = storyboard?.instantiateViewController(withIdentifier: "GameScreenVC") as! GameScreenVC
        
        gameScreenVC.cardsArray = GameModel.fetchCards()
        gameScreenVC.cardsLeft = gameScreenVC.cardsArray!.count
        
        present(gameScreenVC, animated: true, completion: nil)
    }
}
