//
//  Card.swift
//  CardApp(Practice)
//
//  Created by 이민건 on 2/28/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class Card {
    
    var imageName = ""
    var isFlipped = false
    var isMatched = false
    
    init(imageName: String, isFlipped: Bool = false, isMatched: Bool = false) {
        
        self.imageName = imageName
        self.isFlipped = isFlipped
        self.isMatched = isMatched
    }
    
    static func generateCards() -> [Card] {
        
        var cardsArray = [Card]()
        var randNumsArray = [Int]()
        
        for _ in 1...8 {
            
            var randNum = Int.random(in: 1...13)
            while randNumsArray.contains(randNum) {
                randNum = Int.random(in: 1...13)
            }
            
            cardsArray.append(Card(imageName: "card\(randNum)"))
            cardsArray.append(Card(imageName: "card\(randNum)"))
            randNumsArray.append(randNum)
            
            print(randNum)
        }
        
        cardsArray.shuffle()
        
        return cardsArray
    }
}
