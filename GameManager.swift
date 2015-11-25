//
//  GameManager.swift
//  Fight!
//
//  Created by Standa Sučanský on 24/11/15.
//  Copyright © 2015 Standa Sučanský. All rights reserved.
//

import Foundation

class GameManager {
    var players: [Character] = []
    
    func pickCharacter(name: String) {
        var chr: Character
        if name == "Orc" {
            chr = Orc()
        }else if name == "Knight" {
            chr = Knight()
        }else {
            chr = Character(name: "Evil Spawn", startingHP: 1000, atkPwr: 1000)
        }
        players.append(chr)
    }
}