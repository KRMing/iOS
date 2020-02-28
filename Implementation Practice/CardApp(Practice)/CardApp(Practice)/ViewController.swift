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
    
    var timeLeft = 100 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = Card.generateCards()
        cardsLeft = cardsArray?.count
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 158, height: 224)
    }
    
    // MARK: - UICollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var returnValue: Int
        
        if self.cardsArray == nil {
            
            print("cardsArray wasn't properly assigned")
            returnValue = 0
        }
        else {
            
            returnValue = self.cardsArray!.count
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
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            cell?.flipUp()
            
            if firstTouchCell == nil {
                
                firstTouchCell = cell
            }
            else {
                
                checkMatch(secondTouchIndex: indexPath)
            }
        }
    }
    
    // MARK: - Game Logic
    
    func checkMatch(secondTouchIndex: IndexPath) {
        
        let secondCell = self.collectionView.cellForItem(at: secondTouchIndex) as? CardCollectionViewCell
        
        if self.firstTouchCell?.card?.imageName == secondCell?.card?.imageName {
            
            self.firstTouchCell?.remove()
            secondCell?.remove()
            
            self.cardsLeft! -= 2
            
            checkGameEnd()
        }
        else {
            
            self.firstTouchCell?.flipDown()
            secondCell?.flipDown()
        }
        
        self.firstTouchCell = nil
    }
    
    func checkGameEnd() {
        
        if self.cardsLeft! <= 0 {
            
            showAlert(title: "Congratulations!", message: "You've finished the game.")
        }
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
}

