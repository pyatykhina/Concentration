//
//  ViewController.swift
//  Concentration
//
//  Created by Татьяна Пятыхина on 12.09.2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    private(set) var flipCount = 0
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var Themes: Dictionary<String, String> = [
        "Animals": "🐶🐱🐭🐰🦊🐻🐼🐸🐒🦁🐷🐮🐥🐬🐙🐘🐇🐓🐎🐟🦀🐝🦇🐨",
        "Fruits": "🍏🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝",
        "FastFood": "🍔🍟🥫🍕🌮🌯🍱🍿🌭🥐🥠🍝🍤",
        "Faces": "😃😅😂😘😍😇😎😜😡😭😱😵😈🤓😊😴",
        "Sport": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥊⛸🥌🏑🥅",
        "Travel": "⛱🏝🌋🚦🗺🏕🏖🛶🗽🗼🏰🚏🗿🏟🛤",
        "Transport": "🚗🚕🚌🚎🚓🏎🚒🚑🚐🚛🏍🚃✈️🚤🚊⛵️",
        "Numbers": "0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣🔟#️⃣*️⃣",
        "Flags": "🇦🇺🇦🇿🇬🇧🏴󠁧󠁢󠁥󠁮󠁧󠁿🇧🇷🇧🇪🇦🇲🇧🇶🇧🇾🇧🇬🇪🇬🇮🇱🇮🇨🇱🇺🇷🇺🇩🇰🇬🇹"
    ]
    
    private var currentEmojies = ""
    
    private var themeIndex = 0 {
        didSet {
            currentEmojies = Themes[Array(Themes.keys)[themeIndex]]!
            emoji = [Card: String]()
        }
    }
    
    private var themeKeys: [String] {
        return Array(Themes.keys)
    }
    
    private var emoji = [Card: String]()
    
    override func viewDidLoad() {
        themeIndex = themeKeys.count.arc4random
        updateViewFromModel()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.text = "Score: \(game.score)"
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        flipCount = 0
        themeIndex = themeKeys.count.arc4random
        game = newConcentration()
        updateViewFromModel()
    }
    
    private func newConcentration() -> Concentration {
        return Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print ("choosen card is not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
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
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(flipCount)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, currentEmojies.count > 0 {
            let randomStringIndex = currentEmojies.index(currentEmojies.startIndex, offsetBy: currentEmojies.count.arc4random)
            emoji[card] = String(currentEmojies.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
