//
//  Card.swift
//  Concentration
//
//  Created by Татьяна Пятыхина on 21.09.2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory;
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
}
