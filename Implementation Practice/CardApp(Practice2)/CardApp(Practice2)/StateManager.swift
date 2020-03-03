//
//  StateManager.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 3/3/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class StateManager {

    static let bestScoreKey = "BestScoreKey"

    static func saveScore(score: TimeInterval) {

        let defaults = UserDefaults.standard

        var scores = loadScore()
        
        if scores == nil {
            
            scores = [TimeInterval]()
            scores?.append(0)
            scores?.append(0)
            scores?.append(0)
        }
        
        scores!.append(score)
        scores!.sort(by: >)
        scores!.remove(at: 3)

        defaults.set(scores!, forKey: bestScoreKey)
    }

    static func loadScore() -> [TimeInterval]? {

        let defaults = UserDefaults.standard
        
        let scores = defaults.value(forKey: bestScoreKey) as? [TimeInterval]
        
        return scores
    }

}
