//
//  GameModel.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class GameModel {
    
    // TODO: either export as JSON file, or keep it in app, or keep in database
    
    var bestScores: [TimeInterval] = [0, 0, 0]
    
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
        
        for _ in 1...3 {
            
            cardsArray.shuffle()
        }
        
        return cardsArray
    }
    
    // TODO: fix the updateScores function according to the save method chosen above
    
    func updateScores(newScore: TimeInterval) {
        
        bestScores.append(newScore)
        bestScores.sort(by: >)
        bestScores.remove(at: 3)
    }
}
