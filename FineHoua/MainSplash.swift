//
//  MainSplash.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/10/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import SpriteKit
import UIKit

class MainSplash: SKScene {
    
    var nameTextField:UITextField!
    var yourNameLabel:SKLabelNode!
    var fineHouaLabel:SKLabelNode!
    var refreshAlert:UIAlertController!
    
    override func didMoveToView(view: SKView) {
        self.fineHouaLabel = SKLabelNode(fontNamed: "Chalkduster")
        self.yourNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        
        self.fineHouaLabel.fontSize = 66
        self.yourNameLabel.fontSize = 22
        
        self.fineHouaLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.yourNameLabel.color = GameViewController.colorWithHexString("#ffffff")
        
        self.fineHouaLabel.text = "Fine Houa?"
        self.yourNameLabel.text = "Your name"
        
        self.fineHouaLabel.name = "fineHouaLabel"
        self.yourNameLabel.name = "yourNameLabel"
        
        self.fineHouaLabel.position = CGPoint(x: CGRectGetMidX(self.scene!.frame), y: CGRectGetMidY(self.scene!.frame))
        self.yourNameLabel.position = CGPoint(x: CGRectGetMidX(self.scene!.frame), y: CGRectGetMidY(self.scene!.frame) - fineHouaLabel.frame.height)
        
        self.addChild(self.fineHouaLabel)
        self.addChild(self.yourNameLabel)
    }
    
    private func addControls(){
        

    }
    
    private func startGame(){
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }

}
