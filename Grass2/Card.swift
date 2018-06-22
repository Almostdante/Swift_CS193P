//
//  Card.swift
//  Grass2
//
//  Created by Andrey Dmitriev on 05/06/2018.
//  Copyright © 2018 AndreyDmitriev. All rights reserved.
//

import Foundation

struct Card
{
    var isFace = false
    var isMatch = false
    var cardID: Int
    var wasFaced = false
    
    static var iDFactory = 0
    
    static func getUID() -> Int {
        iDFactory += 1
        return iDFactory
    }
    
    init() {
        self.cardID = Card.getUID()
    }
}
