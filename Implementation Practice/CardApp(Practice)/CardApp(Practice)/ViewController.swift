//
//  ViewController.swift
//  CardApp(Practice)
//
//  Created by 이민건 on 2/28/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardsArray: [Card]?
    var cardsLeft: Int?
    var firstTouchCell: CardCollectionViewCell?
    var timer: Timer?
    var sound: SoundManager?
    
    var timeLeft: Double = 30 * 1000
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cardsArray = Card.generateCards()
        cardsLeft = cardsArray?.count
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        sound = SoundManager()
        sound?.playSound(effect: .shuffle)
    }
    
    // MARK: - Timer Method
    
    @objc func timerFired() {
        
        timeLeft -= 1
        
        timerLabel.text = String(format: "Time Remaining: %.2f", timeLeft / 1000.0)
        
        if timeLeft == 0 {
            
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
            
            checkGameEnd()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 158, height: 224)
    }
    
    // MARK: - UICollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var returnValue: Int
        
        if cardsArray == nil {
            
            print("cardsArray wasn't properly assigned")
            returnValue = 0
        }
        else {
            
            returnValue = cardsArray!.count
        }
        
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as? CardCollectionViewCell
        
        cell?.reloadCell(card: cardsArray![indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
//        print("selected cell: \(cell)")
//        print("selected cell card name: \(cell?.card?.imageName)")
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false && timeLeft > 0 {
            
            cell?.flipUp()
            
            if firstTouchCell == nil {
                
                firstTouchCell = cell
                
                sound?.playSound(effect: .flip)
            }
            else {
                
                checkMatch(secondTouchIndex: indexPath)
            }
        }
    }
    
    // MARK: - Game Logic
    
    func checkMatch(secondTouchIndex: IndexPath) {
        
        let secondCell = collectionView.cellForItem(at: secondTouchIndex) as? CardCollectionViewCell
        
//        print("checking match : ")
//        print("first cell : \(firstTouchCell!), card name: \(firstTouchCell!.card?.imageName)")
//        print("second cell : \(secondCell!), card name: \(secondCell!.card?.imageName)")
//        print()
        
        if firstTouchCell?.card?.imageName == secondCell?.card?.imageName {
            
            firstTouchCell?.remove()
            secondCell?.remove()
            
            cardsLeft! -= 2
            
            checkGameEnd()
            
            sound?.playSound(effect: .match)
        }
        else {
            
            firstTouchCell?.flipDown()
            secondCell?.flipDown()
            
            sound?.playSound(effect: .nomatch)
        }
        
        firstTouchCell = nil
    }
    
    func checkGameEnd() {
        
        if cardsLeft! <= 0 && timeLeft > 0 {
                
            timer?.invalidate()
            showAlert(title: "Congratulations!", message: "You've finished the game.")
        }
        else if cardsLeft! > 0 && timeLeft <= 0 {
            
            showAlert(title: "Times up!", message: "Better luck next time.")
        }
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
}

