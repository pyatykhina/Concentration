//
//  ViewController.swift
//  Concentration
//
//  Created by Татьяна Пятыхина on 12.09.2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐶", "🐱", "🐭", "🐰", "🦊", "🐻"]
    
    var emoji = [Int: String] ()
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print ("choosen card is not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.8896149993, blue: 0.7366457582, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear :#colorLiteral(red: 0.7042355537, green: 0.4285730422, blue: 0.3668116331, alpha: 1)
            }
        }
    }

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        return emoji[card.identifier] ?? "?"
    }
}
