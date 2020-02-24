//
//  CardModel.swift
//  MatchApp
//
//  Created by 이민건 on 2/24/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class CardModel {
    func getCards() -> [Card] {
        var generatedCards = [Card]()
        var checkInsideDeck = [Int]()
        
        for _ in 1...8 {
            var randomNumber = Int.random(in: 1...13)
            while checkInsideDeck.contains(randomNumber) {
                randomNumber = Int.random(in: 1...13)
            }
            
//            while true {
//                var isIn = false
//                var idx = 0
//                while idx < generatedCards.count {
//                    if generatedCards[idx].imageName == "card\(randomNumber)" {
//                        isIn = true
//                        break
//                    }
//                    idx += 1
//                }
//                if isIn {
//                    randomNumber = Int.random(in: 1...13)
//                }
//                else {
//                    break;
//                }
//            }
            
            let cardOne = Card(imageName: "card\(randomNumber)", isMatched: false, isFlipped: false)
            let cardTwo = Card(imageName: "card\(randomNumber)", isMatched: false, isFlipped: false)
            checkInsideDeck.append(randomNumber)
            
            generatedCards += [cardOne, cardTwo]
            
            print(randomNumber)
        }
        
        generatedCards.shuffle()
        
        return generatedCards
    }
}
