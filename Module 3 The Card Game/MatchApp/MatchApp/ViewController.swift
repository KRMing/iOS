//
//  ViewController.swift
//  MatchApp
//
//  Created by 이민건 on 2/24/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var timer: Timer?
    var milliseconds:Int = 30 * 1000
    
    var firstFlippedCardIndex: IndexPath?

    var soundPlayer = SoundManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
        
        // Set the view controller as the datasource and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        // fixes the problem of timer pausing when scrolling through the screen
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // play shuffling sound
        soundPlayer.playSound(effect: .shuffle)
    }
    
    // MARK: - Timer Methods
    
    // timer function per tick
    @objc func timerFired() {
        milliseconds -= 1
        
        // update and display seconds per tick on the label
        let seconds: Double = Double(milliseconds)/1000.0
        timerLabel.text = String(format: "Time Remaining: %.3f", seconds)
        
        if milliseconds == 0 {
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
            
            // TODO: check if user has cleared all pairs
            checkForGameEnd()
        }
    }
    
    // MARK: - Collection View Delegete Methods
    
    // setting image size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 158, height: 224)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardsArray.count
    }
    
    // reusing cell method
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        return cell
    }
    
    // configure the state of the cell based on the properties of the card that it represents (double checking)
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cardCell = cell as? CardCollectionViewCell
        
        // TODO: configure it
        cardCell?.configureCell(card: cardsArray[indexPath.row])
    }
    
    // detects if user touched the card
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if milliseconds <= 0 {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            cell?.flipUp()
            
            soundPlayer.playSound(effect: .flip)
            
            // if it is the first selected card, assign the index
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else { // if the second card is selected, check for match
                checkForMatch(indexPath)
            }
        }
        
    }
    
    // MARK: - Game Logic Methods
    
    func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // is it a match?
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            soundPlayer.playSound(effect: .match)
            
            // is it the last pair?
            checkForGameEnd()
        }
        else { // since it isn't a match, flip the two cards down
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            soundPlayer.playSound(effect: .nomatch)
        }
        
        firstFlippedCardIndex = nil
    }
    
    func checkForGameEnd() {
        for card in cardsArray {
            if !card.isMatched {
                // there are still some cards left
                if milliseconds <= 0 {
                    showAlert(title: "Time's up!", message: "Sorry, better luck next time!")
                }
                
                return
            }
        }
        
        // player has won
        showAlert(title: "Congratulations!", message: "You've won the game!")
        timer?.invalidate()
    }
    
    func showAlert(title: String, message: String) {
        // the alert message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // the button inside the alert message
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        // add the button action to alert message
        alert.addAction(dismissAction)
        
        // display the alert message onto the screen
        present(alert, animated: true, completion: nil)
    }
}

