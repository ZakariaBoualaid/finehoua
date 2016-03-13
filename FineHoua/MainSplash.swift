//
//  MainSplash.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/10/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import CoreData

var xMid:CGFloat!
var yMid:CGFloat!
var xMax:CGFloat!
var yMax:CGFloat!
var yMaxView:CGFloat!
var yMidView:CGFloat!
var appBgColor:String! = "#19191a"
var appBgColorGame:String! = "#000000"

class MainSplash: SKScene, UITextFieldDelegate {
    
    @IBOutlet var showConfigSceneButton:UIButton!
    var fineHouaLabel:SKLabelNode!
    var refreshAlert:UIAlertController!
    
    // Init variables about the scene
    private func initVars(){
        xMid = CGRectGetMidX(self.scene!.frame)
        yMid = CGRectGetMidY(self.scene!.frame)
        xMax = CGRectGetMaxX(self.scene!.frame)
        yMax = CGRectGetMaxY(self.scene!.frame)
        yMaxView = CGRectGetMaxY(self.view!.frame)
        yMidView = CGRectGetMidY(self.view!.frame)
    }

    override func didMoveToView(view: SKView) {
        currentPlayer = nil
        self.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        mainSplash = self
        initVars()
        showControls()
    }
    
    override func willMoveFromView(view: SKView) {
        currentPlayer = Player()
        allPlayers.append(currentPlayer)
    }
    
    // Show controls on the scene
    private func showControls(){
        // Game Title & Label
        self.fineHouaLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.fineHouaLabel.fontSize = 66
        self.fineHouaLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.fineHouaLabel.text = "Fine Houa Nicolas"
        self.fineHouaLabel.name = "fineHouaLabel"
        GameViewController.adjustLabelFontSizeToFitRect(self.fineHouaLabel, rect: self.scene!.frame, ratio: 2.00)
        self.fineHouaLabel.position = CGPoint(x: xMid, y: yMax - 130.00)
        self.addChild(self.fineHouaLabel)

        self.showConfigSceneButton = UIButton(frame: CGRect(x: xMid - 150.00, y: yMid + 20, width: 300.00, height: 55.00))
        self.showConfigSceneButton.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.showConfigSceneButton.setTitle("Start", forState: UIControlState.Normal)
        self.showConfigSceneButton.titleLabel!.font = UIFont(name: "Copperplate", size: 25.00)
        self.showConfigSceneButton.addTarget(self, action: "showConfigPressed:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(showConfigSceneButton)
    }
    
    func showConfigPressed(sender: UIButton!){
        showConfig()
    }
    
    private func showConfig() -> Bool {
            configScene = ConfigScene(fileNamed: "ConfigScene")
            configScene.scaleMode = .ResizeFill
            let transition = SKTransition.crossFadeWithDuration(0.15)
            self.view!.presentScene(configScene, transition: transition)
            hideUIControls()
            return true
    }
    
    private func hideUIControls(){
        self.showConfigSceneButton.hidden = true
    }

}
