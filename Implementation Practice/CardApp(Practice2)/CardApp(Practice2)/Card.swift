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
}
