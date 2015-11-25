//
//  Orc.swift
//  Fight!
//
//  Created by Standa Sučanský on 24/11/15.
//  Copyright © 2015 Standa Sučanský. All rights reserved.
//

import Foundation

class Orc: Character {

    override var type:String {
        get {
            return "Orc"
        }
    }
    
    convenience init() {
        self.init(name: "Orc", startingHP: 110, atkPwr: 20)
    }
}