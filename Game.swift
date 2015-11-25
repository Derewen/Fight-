//
//  Game.swift
//  Fight!
//
//  Created by Standa Sučanský on 25/11/15.
//  Copyright © 2015 Standa Sučanský. All rights reserved.
//

import Foundation

class Game {
    private var _isRunning: Bool = false
    var isRunning: Bool {
        get {
            return _isRunning
        }
    }
    
    func changeState(state: Bool) {
        _isRunning = state
    }
}