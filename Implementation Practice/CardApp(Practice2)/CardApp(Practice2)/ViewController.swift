//
//  ViewController.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardsArray: [Card]?
    var cardsLeft: Int = 0

    var firstSelectIndex: IndexPath?
    
    var timeLeft: TimeInterval = 50 * 1000
    var timer: Timer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cardsArray = Card.fetchCards()
        cardsLeft = cardsArray!.count
        
        collectionView.delegate = self
        collectionView.dataSource = self

        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    // MARK: Timer Functions
    
    @objc func fireTimer() {
        
        timeLeft -= 1
        
        timerLabel.text = String(format: "Time Left: %.3f", Double(timeLeft) / 1000.0)
        
        if timeLeft == 0 {
            
            timer?.invalidate()
            timer = nil
            
            timerLabel.textColor = UIColor.red
            
            checkGameEnd()
        }
    }
    
    // MARK: - UICollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardsArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        return cardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cardCell = cell as! CardCollectionViewCell
        
        cardCell.reloadCard(card: cardsArray![indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = cardsArray![indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        if !card.isFlipped && !card.isMatched && timeLeft > 0 {
            
            cell.flipUp()

            if firstSelectIndex == nil {
                
                firstSelectIndex = indexPath
            }
            else {
                
                checkMatch(secondSelectIndex: indexPath)
            }
        }
    }
    
    // MARK: - Game Logic
    
    func checkMatch(secondSelectIndex: IndexPath) {
        
        let firstCard = cardsArray![firstSelectIndex!.row]
        let secondCard = cardsArray![secondSelectIndex.row]
        
        let firstCell = collectionView.cellForItem(at: firstSelectIndex!) as? CardCollectionViewCell
        let secondCell = collectionView.cellForItem(at: secondSelectIndex) as! CardCollectionViewCell
        
        if firstCard.frontImageName == secondCard.frontImageName {

            firstCell?.remove()
            secondCell.remove()
            
            firstCard.isMatched = true // there is a possibility that the firstCell might be nil (when out of visible scope)
            secondCard.isMatched = true // so we add manipulate the array directly using the IndexPath
            
            cardsLeft -= 2

            checkGameEnd()
        }
        else {

            firstCell?.flipDown()
            secondCell.flipDown()
            
            firstCard.isFlipped = false // same here as well
            secondCard.isFlipped = false
        }

        firstSelectIndex = nil
    }
    
    func checkGameEnd() {
        
        if cardsLeft <= 0 && timeLeft > 0 {
            
            timer?.invalidate()
            
            showAlert(title: "Congratulations!", message: "You've won the game!")
        }
        else if cardsLeft > 0 && timeLeft <= 0 {

            showAlert(title: "Oops, times Up!", message: "Better luck next time!")
        }
    }
    
    // MARK: Supplementary Functions
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

