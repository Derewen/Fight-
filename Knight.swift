//
//  Knight.swift
//  Fight!
//
//  Created by Standa Sučanský on 24/11/15.
//  Copyright © 2015 Standa Sučanský. All rights reserved.
//

import Foundation

class Knight: Character {
    
    override var type:String {
        get {
            return "Knight"
        }
    }
    
    convenience init() {
        self.init(name: "Knight", startingHP: 95, atkPwr: 30)
    }
   
}