//
//  MatchGameModel.swift
//  CardApp(Practice3)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class MatchGameModel {
    
    static func shuffleCards() -> [Card] {
        
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
        }
        
        cardsArray.shuffle()
        
        return cardsArray
    }
}
