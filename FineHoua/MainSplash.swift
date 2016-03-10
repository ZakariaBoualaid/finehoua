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
    var xMid:CGFloat!
    var yMid:CGFloat!
    var xMax:CGFloat!
    var yMax:CGFloat!

    
    override func didMoveToView(view: SKView) {
        initVars()
        addControls()
    }
    
    private func addControls(){
        // Game Title & Label
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
        self.fineHouaLabel.position = CGPoint(x: self.xMid, y: self.yMax - 100.00)
        self.yourNameLabel.position = CGPoint(x: self.xMid, y: self.yMid - 50.00)
        self.addChild(self.fineHouaLabel)
        // self.addChild(self.yourNameLabel)
        
        self.nameTextField = UITextField(frame: CGRect(x: self.xMid - 175.00, y: self.yMid - 50, width: 350.00, height: 55.00))
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Your name", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.nameTextField.textColor = UIColor.whiteColor()
        self.nameTextField.font = UIFont(name: "Chalkduster", size: 24.00)
        self.nameTextField.backgroundColor = GameViewController.colorWithHexString("#232323")
        self.nameTextField.tintColor = GameViewController.colorWithHexString("#ffffff")
        self.nameTextField.textAlignment = .Center
        self.view!.addSubview(nameTextField)
    }
    
    private func startGame(){
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
    
    private func initVars(){
        self.xMid = CGRectGetMidX(self.scene!.frame)
        self.yMid = CGRectGetMidY(self.scene!.frame)
        self.xMax = CGRectGetMaxX(self.scene!.frame)
        self.yMax = CGRectGetMaxY(self.scene!.frame)
    }

}
