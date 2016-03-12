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
    var nbrOfGames: Int = 0
    var hasNewBestScore: Bool = false
    
    init() {}
    
    func setNewScore(newScore: Float) -> Bool {
        self.nbrOfGames = self.nbrOfGames+1
        self.score = newScore
        if(self.bestScore == 0 || self.score < self.bestScore){
            self.bestScore = self.score
            self.hasNewBestScore = true
        } else {
            self.hasNewBestScore = false
        }
        self.showInfoInConsole()
        return self.hasNewBestScore
    }
    
    func isNewPlayer() -> Bool {
        return (self.nbrOfGames == 0 || self.name == nil || self.name == "")
    }
    
    func scoreToString() -> String {
        var labelForZero = ""
        if self.score < 10 { labelForZero = "0" } else { labelForZero = "" }
        return "\(labelForZero)\(String(format: "%.2f", self.score))"
    }
    
    func bestScoreToString() -> String {
        var labelForZero = ""
        if self.bestScore < 10 { labelForZero = "0" } else { labelForZero = "" }
        return "\(labelForZero)\(String(format: "%.2f", self.bestScore))"
    }
    
    func showInfoInConsole() {
        print("PLAYER: \(self.name), SCORE: \(self.score), BEST SCORE: \(self.bestScore), GAMES: \(self.nbrOfGames), HAS_NEW_SCORE: \(self.hasNewBestScore)")
    }
}