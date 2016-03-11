//
//  Player.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/11/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import Foundation

class Player {
    var name: String!
    var score: Float! = 0
    var bestScore: Float! = 0
    var nbrOfGames: Int32 = 0
    
    init(name: String) {
        self.name = name
        self.bestScore = 0
        self.score = 0
        self.nbrOfGames = 0
    }
    
    private func setNewScore() -> Bool {
        self.nbrOfGames++
        if(self.bestScore == 0 || self.score < self.bestScore){
            self.bestScore = self.score
            return true
        }
        return false
    }
}