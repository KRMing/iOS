//
//  CardCollectionViewCell.swift
//  CardApp(Practice)
//
//  Created by 이민건 on 2/28/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontCardImage: UIImageView!
    
    @IBOutlet weak var backCardImage: UIImageView!
    
    var card: Card?
    
    func reloadCell(card: Card) {
        
        self.card = card
        
        self.frontCardImage.image = UIImage(named: "\(card.imageName)")
        self.backCardImage.image = UIImage(named: "back")
        
        if self.card!.isMatched {
            
            self.frontCardImage.alpha = 0
            self.backCardImage.alpha = 0
            
            return
        }
        else {
            
            self.frontCardImage.alpha = 1
            self.backCardImage.alpha = 1
        }
        
        if self.card!.isFlipped {
            
            flipUp(speed: 0)
        }
        else {
            
            flipDown(speed: 0, delay: 0)
        }
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        UIView.transition(from: self.backCardImage, to: self.frontCardImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        self.card?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.3) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            UIView.transition(from: self.frontCardImage, to: self.backCardImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        }
        
        self.card?.isFlipped = false
    }
    
    func remove() {
        
        self.backCardImage.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontCardImage.alpha = 0
        }, completion: nil)
        
        self.card?.isMatched = true
    }
}
