//
//  Card.swift
//  MatchApp
//
//  Created by 이민건 on 2/24/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class Card {
    var imageName: String
    var isMatched: Bool
    var isFlipped: Bool
    
    init() {
        self.imageName = ""
        self.isFlipped = false
        self.isMatched = false
    }
    
    init(imageName: String, isMatched: Bool = false, isFlipped: Bool = false) {
        self.imageName = imageName
        self.isMatched = isMatched
        self.isFlipped = isFlipped
    }
    
}
