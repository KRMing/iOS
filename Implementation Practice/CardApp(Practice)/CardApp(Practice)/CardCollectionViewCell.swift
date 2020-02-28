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
    
    func loadCard(card: Card) {
        
        self.card = card
        
        frontCardImage.image = UIImage(named: "\(card.imageName)")
        backCardImage.image = UIImage(named: "back")
        
        if card.isFlipped {
            
        }
        else {
            
        }
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        UIView.transition(from: backCardImage, to: frontCardImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        card?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.3) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            UIView.transition(from: self.frontCardImage, to: self.backCardImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        }
        
        card?.isFlipped = false
    }
    
    func remove() {
        
    }
}
