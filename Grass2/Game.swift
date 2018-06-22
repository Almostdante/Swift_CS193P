//
//  Game.swift
//  Grass2
//
//  Created by Andrey Dmitriev on 05/06/2018.
//  Copyright © 2018 AndreyDmitriev. All rights reserved.
//

import Foundation

class Game
{
    
    private(set) var gameScore: Int
    private(set) var flipCnt: Int
    var cards = [Card]()
    var indexofOnly: Int? {
        get {
            var thatIndex: Int? = nil
            for x in cards.indices {
                if cards[x].isFace {
                    if thatIndex == nil{
                        thatIndex = x
                    }
                    else {
                        return nil
                    }
                }
            }
            return thatIndex
        }
        set {
            for x in cards.indices {
                cards[x].isFace = (x == newValue)
            }
        }
    }
    func chooseCard(at index: Int)
    { assert(cards.indices.contains(index), "Game, choose, \(index)) out af array")
        if !cards[index].isMatch, indexofOnly != index, !cards[index].isFace {
            flipCnt += 1
            if indexofOnly != nil {
                if cards[index].cardID == cards[indexofOnly!].cardID {
                    cards[index].isMatch = true
                    cards[indexofOnly!].isMatch = true
                    gameScore += 2
                    
                }
                else {
                    gameScore -= ((cards[index].wasFaced ? 1 : 0) + (cards[indexofOnly!].wasFaced ? 1 : 0))
                    cards[index].wasFaced = true
                    cards[indexofOnly!].wasFaced = true
                }
                cards[index].isFace = true
            }
            else {
                indexofOnly = index
                
            }
        }
        
    }
    init(numberOfCards: Int)
    { assert(numberOfCards > 0, "Game, init, \(numberOfCards) is not enough" )
        gameScore = 0
        flipCnt = 0
        for _ in 1...numberOfCards/2
        {
            let card = Card()
            cards.insert(card, at: cards.endIndex.justRandom)
            cards.insert(card, at: cards.endIndex.justRandom)
        }
    }
}

