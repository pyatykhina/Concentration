//
//  Concentration.swift
//  Concentration
//
//  Created by Татьяна Пятыхина on 21.09.2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//
import Foundation

private struct Score {
    static let cardsIsMatched = 2
    static let cardsIsNotMatched = -1
}

struct Concentration {
    
    private(set) var score = 0
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): choosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += Score.cardsIsMatched
                } else if score > 0 {
                    score += Score.cardsIsNotMatched
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
}

extension Array {
    mutating func shuffle(){
        if count > 1 {
            // dropLast() - подпоследовательность, содержащая все элементы последовательности, кроме последнего
            for i in indices.dropLast() {
                let diff = distance(from: i, to: endIndex)
                let j = index(i, offsetBy: diff.arc4random)
                swapAt(i, j)
            }
        } else {
            return
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
