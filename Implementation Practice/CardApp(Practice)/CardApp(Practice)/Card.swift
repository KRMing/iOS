//
//  Card.swift
//  CardApp(Practice)
//
//  Created by 이민건 on 2/28/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

struct Card {
    
    var imageName = ""
    var isFlipped = false
    var isMatched = false
    
    init(imageName: String, isFlipped: Bool = false, isMatched: Bool = false) {
        
        self.imageName = imageName
        self.isFlipped = isFlipped
        self.isMatched = isMatched
    }
}
