//
//  ViewController.swift
//  Grass2
//
//  Created by Andrey Dmitriev on 31/05/2018.
//  Copyright © 2018 AndreyDmitriev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Game(numberOfCards: (allCards.count))
    @IBAction func NewGame(_ sender: UIButton) {
        game = Game(numberOfCards: (allCards.count))
        setTheme()
        updateVFM()
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCntLabel: UILabel!
    @IBOutlet var allCards: [UIButton]!
    var emojiThemes = [["👻","💀","☠️","👽","🎃","😈","👿","👺"], ["👮‍♂️","👳‍♀️","🧜‍♂️","😘","😇","😍","🤓","😎"], ["🐶","🐱","🐭","🐰","🐽","🦄","🦆","🦈"]]
    var currentEmojiSet: Array <String>?
    @IBAction func touchC(_ sender: UIButton) {
        if let cNumber = allCards.index(of: sender) {
            game.chooseCard(at: cNumber)
            updateVFM()
        }
    }
    private func setTheme() -> Array <String> {
        let x = emojiThemes.count.justRandom
        return emojiThemes[x]
    }
    private var emoji = Dictionary <Int, String>()
    private func emoji (for card: Card) -> String {
        if currentEmojiSet == nil{
           currentEmojiSet = setTheme()
        }
        if emoji[card.cardID] == nil, currentEmojiSet!.count > 0 {
            let ranIndex = currentEmojiSet!.count.justRandom
            emoji[card.cardID] = currentEmojiSet!.remove(at: ranIndex)
        }
        return emoji[card.cardID] ?? "?"
    }
    
    private func updateVFM () {
        for i in 0..<allCards.count {
            let cur_button = allCards[i]
            let cur_card = game.cards[i]
            if cur_card.isFace {
                cur_button.setTitle(emoji(for: cur_card), for: UIControlState.normal)
                cur_button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
            else {
                cur_button.setTitle("", for: UIControlState.normal)
                cur_button.backgroundColor = cur_card.isMatch ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                
            }
        }
        scoreLabel.text = "Score: \(game.gameScore)"
        flipCntLabel.text = "Flips: \(game.flipCnt)"
    }
    
    
}
extension Int {
    var justRandom: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}

