//
//  Card.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class Card {
    
    var frontImageName = ""
    var isFlipped = false
    var isMatched = false
    
    init(frontImageName: String, isFlipped: Bool = false, isMatched: Bool = false) {
        
        self.frontImageName = frontImageName
        self.isFlipped = isFlipped
        self.isMatched = isMatched
    }
    
    static func fetchCards() -> [Card] {
        
        var cardsArray = [Card]()
        var randNumsArray = [Int]()
        
        for _ in 1...8 {
            
            var randNum = Int.random(in: 1...13)
            while randNumsArray.contains(randNum) {
                
                randNum = Int.random(in: 1...13)
            }
            
            cardsArray.append(Card(frontImageName: "card\(randNum)"))
            cardsArray.append(Card(frontImageName: "card\(randNum)"))
            randNumsArray.append(randNum)
        }
        
        cardsArray.shuffle()
        
        return cardsArray
    }
}
