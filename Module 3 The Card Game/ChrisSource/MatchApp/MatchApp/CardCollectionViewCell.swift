//
//  CardCollectionViewCell.swift
//  MatchApp
//
//  Created by Christopher Ching on 2019-07-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func configureCell(card:Card) {
        
        // Keep track of the card this cell represents
        self.card = card
        
        // Set the front image view to the image that represents the card
        frontImageView.image = UIImage(named: card.imageName)
        
        // Reset the state of the cell by checking the flipped status of the card and then showing the front or the back imageview accordingly
        
        if card.isFlipped == true {
            // Show the front image view
            flipUp(speed: 0)
        }
        else {
            // Show the back image view
            flipDown(speed: 0)
        }
    }
    
    func flipUp(speed:TimeInterval = 0.3) {
        
        // Flip up animation 
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        // Set the status of the card
        card?.isFlipped = true
    }
    
    func flipDown(speed:TimeInterval = 0.3) {
        
        // Flip down animation
        UIView.transition(from: frontImageView, to: backImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        // Set the status of the card
        card?.isFlipped = false
    }
}
