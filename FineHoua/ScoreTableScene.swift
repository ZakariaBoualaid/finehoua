//
//  ScoreTableScene.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/11/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import UIKit
import SpriteKit

class ScoreTableScene: SKScene {

    var yourScoreLabel:SKLabelNode!
    var yourBestScoreLabel:SKLabelNode!
    var congratNewScoreLabel:SKLabelNode!
    @IBOutlet var replayGameButton:UIButton!
    @IBOutlet var showHallOfFame:UIButton!
    @IBOutlet var backToSplash:UIButton!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        scoreTableScene = self
        showTable(); if currentPlayer.hasNewBestScore {showCongratForNewScore()}
    }
    
    private func showTable () {
        self.yourScoreLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.yourScoreLabel.fontSize = adapt(25)
        self.yourScoreLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.yourScoreLabel.text = "Your score : \(currentPlayer.scoreToString())"
        //GameViewController.adjustLabelFontSizeToFitRect(self.yourScoreLabel, rect: self.scene!.frame, ratio: 3)
        self.yourScoreLabel.name = "yourScoreLabel"
        self.yourScoreLabel.position = CGPoint(x: xMid, y: yMidView + adapt(80))
        self.addChild(self.yourScoreLabel)
        
        self.yourBestScoreLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.yourBestScoreLabel.fontSize = adapt(30)
        self.yourBestScoreLabel.color = GameViewController.colorWithHexString("#ffffff")
        if currentPlayer.hasNewBestScore {self.yourBestScoreLabel.color = GameViewController.colorWithHexString("#ffffff")}
        self.yourBestScoreLabel.text = "Your best score : \(currentPlayer.bestScoreToString())"
        //GameViewController.adjustLabelFontSizeToFitRect(self.yourBestScoreLabel, rect: self.scene!.frame, ratio: 3)
        self.yourBestScoreLabel.name = "yourBestScoreLabel"
        self.yourBestScoreLabel.position = CGPoint(x: xMid, y: yMidView + adapt(30))
        self.addChild(self.yourBestScoreLabel)

        self.replayGameButton = UIButton(frame: CGRect(x: xMid - adapt(150), y: yMid + adapt(20), width: adapt(300), height: adapt(55)))
        self.replayGameButton.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.replayGameButton.setTitle("Replay", forState: UIControlState.Normal)
        self.replayGameButton.titleLabel!.font = UIFont(name: "Copperplate", size: adapt(30.00))
        self.replayGameButton.addTarget(self, action: "replayPressed:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(replayGameButton)
        
        self.showHallOfFame = UIButton(frame: CGRect(x: xMid - adapt(150), y: yMid + adapt(80), width: adapt(300), height: adapt(55)))
        self.showHallOfFame.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.showHallOfFame.setTitle("Hall of Fame", forState: UIControlState.Normal)
        self.showHallOfFame.titleLabel!.font = UIFont(name: "Copperplate", size: adapt(30.00))
        self.showHallOfFame.addTarget(self, action: "showHallOfFamePressed:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(showHallOfFame)
        
        self.backToSplash = UIButton(frame: CGRect(x: xMid - adapt(150), y: yMid + adapt(140), width: adapt(300), height: adapt(55)))
        self.backToSplash.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.backToSplash.setTitle("New Player", forState: UIControlState.Normal)
        self.backToSplash.titleLabel!.font = UIFont(name: "Copperplate", size: adapt(30.00))
        self.backToSplash.addTarget(self, action: "backToSplashPressed:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(backToSplash)
    }
    
    func adapt(f: CGFloat) -> CGFloat {
        return self.view!.frame.width / (1024 / f)
    }
    
    func showHallOfFamePressed(sender: UIButton) {
        GameViewController.showHallOfFame(scoreTableScene)
    }
    
    func backToSplashPressed(sender: UIButton) {
        GameViewController.backToSplash(scoreTableScene)
    }
    
    func replayPressed(sender: UIButton!){
        GameViewController.restartGame()
    }
    
    private func showCongratForNewScore(){
        self.congratNewScoreLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.congratNewScoreLabel.fontSize = 33
        self.congratNewScoreLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.congratNewScoreLabel.text = "\(currentPlayer.name.capitalizedString), You have a new best score!"
        GameViewController.adjustLabelFontSizeToFitRect(self.congratNewScoreLabel, rect: self.scene!.frame, ratio: 1.5)
        self.congratNewScoreLabel.name = "congratNewScoreLabel"
        self.congratNewScoreLabel.position = CGPoint(x: xMid, y: yMax - adapt(100))
        self.addChild(self.congratNewScoreLabel)
    }
    
}
