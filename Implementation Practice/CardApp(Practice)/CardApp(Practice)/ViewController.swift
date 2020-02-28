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
    
    var timeLeft = 100 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = GameModel.generateCards()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // when user touches the card
        
    }
}

