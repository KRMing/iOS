//
//  ViewController.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardsArray: [Card]?
    var cardsLeft: Int = 0
    
    var firstSelectedCell: CardCollectionViewCell?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cardsArray = Card.fetchCards()
        cardsLeft = cardsArray!.count
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.clear
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
        
        print(cardsArray![indexPath.row].frontImageName)
        
        let cardCell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        if cardCell.card?.isFlipped == false && cardCell.card?.isMatched == false {
            
            cardCell.flipUp()
            
            if firstSelectedCell == nil {
                
                firstSelectedCell = cardCell
            }
            else {
                
                checkMatch(secondSelectedCell: cardCell)
            }
        }
    }
    
    // MARK: - Game Logic
    
    func checkMatch(secondSelectedCell: CardCollectionViewCell) {

        print(firstSelectedCell!.card!.frontImageName)
        print(secondSelectedCell.card!.frontImageName)
        
        if firstSelectedCell!.card!.frontImageName == secondSelectedCell.card!.frontImageName {

            firstSelectedCell!.remove()
            secondSelectedCell.remove()

            cardsLeft -= 2

            checkGameEnd()
        }
        else {

            firstSelectedCell!.flipDown()
            secondSelectedCell.flipDown()
        }

        firstSelectedCell = nil
    }
    
    func checkGameEnd() {
        
        if cardsLeft <= 0 {
            
            showAlert(title: "Congratulations!", message: "You've won the game!")
        }
//        else {
//
//            showAlert(title: "Oops!", message: "Better luck next time!")
//        }
    }
    
    // MARK: Supplimentary Functions
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

