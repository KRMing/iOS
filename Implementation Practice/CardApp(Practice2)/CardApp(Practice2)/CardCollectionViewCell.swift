//
//  CardCollectionViewCell.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardFrontImage: UIImageView!
    
    @IBOutlet weak var cardBackImage: UIImageView!
    
    var card: Card?
    
    func reloadCard(card: Card) {
                
        self.card = card
        
        cardFrontImage.image = UIImage(named: card.frontImageName)
        cardBackImage.image = UIImage(named: "back")

        if self.card!.isMatched {
            
            cardFrontImage.alpha = 0
            cardBackImage.alpha = 0
            
            return
        }
        else {
            
            cardFrontImage.alpha = 1
            cardBackImage.alpha = 1
        }
        
        if self.card!.isFlipped {
            
            flipUp(speed: 0)
        }
        else {
            
            flipDown(speed: 0, delay: 0)
        }
    }
    
    // MARK: Image Transitions
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        UIImageView.transition(from: cardBackImage, to: cardFrontImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        self.card!.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.3) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            UIImageView.transition(from: self.cardFrontImage, to: self.cardBackImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        }
        
        self.card!.isFlipped = false
    }
    
    func remove(speed: TimeInterval = 0.3, delay: TimeInterval = 0.5) {
        
        self.cardBackImage.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
        
            UIImageView.animate(withDuration: speed) {
                
                self.cardFrontImage.alpha = 0
            }
        }
        
        self.card!.isMatched = true
    }
}
