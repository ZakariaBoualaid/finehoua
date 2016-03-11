//
//  ConfigScene.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/11/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import UIKit
import SpriteKit

var gameDifficulty:String?

class ConfigScene: SKScene {
    
    var gameDescLabel:SKLabelNode!
    @IBOutlet var startButton:UIButton!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        showControls()
    }
    
    private func showControls(){
        self.gameDescLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.gameDescLabel.fontSize = 23
        self.gameDescLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.gameDescLabel.text = "The goal is to find Nicolas Cage. Click to start when you're ready."
        GameViewController.adjustLabelFontSizeToFitRect(self.gameDescLabel, rect: self.scene!.frame, ratio: 1.1)
        self.gameDescLabel.name = "gameDescLabel"
        self.gameDescLabel.position = CGPoint(x: xMid, y: yMid + 40)
        self.addChild(self.gameDescLabel)
        
        self.startButton = UIButton(frame: CGRect(x: xMid - 150.00, y: yMid + 20, width: 300.00, height: 55.00))
        self.startButton.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.startButton.setTitle("Start", forState: UIControlState.Normal)
        self.startButton.titleLabel!.font = UIFont(name: "Copperplate", size: 30.00)
        self.startButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(startButton)
    }
    
    private func hideControls(){
        self.startButton.hidden = true
    }
    
    func pressed(sender: UIButton!){
        hideControls()
        let gameScene = GameScene(fileNamed: "GameScene")
        let transition = SKTransition.fadeWithDuration(0.15)
        self.view!.presentScene(gameScene!, transition: transition)
    }

}
