//
//  NewPlayerScene
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/11/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import UIKit
import SpriteKit

class NewPlayerScene: SKScene, UITextFieldDelegate {
    
var successMsgLabel:SKLabelNode!
@IBOutlet var nameTextField:UITextField!
var congratNewScoreLabel:SKLabelNode!
var newScoreLabel:SKLabelNode!
@IBOutlet var saveScoreButton:UIButton!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        showSuccessMessage(); if currentPlayer.hasNewBestScore && self.view!.frame.height > 600 {showCongratForNewScore()}
    }
    
    override func willMoveFromView(view: SKView) {
        
    }
    
    private func showSuccessMessage(){
        self.nameTextField = UITextField(frame: CGRect(x: xMid - 150.00, y: yMid - 10, width: 300.00, height: 55.00))
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Your name", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.nameTextField.textColor = UIColor.whiteColor()
        self.nameTextField.font = UIFont(name: "Futura-Medium", size: 20.00)
        self.nameTextField.backgroundColor = GameViewController.colorWithHexString("#232323")
        self.nameTextField.tintColor = GameViewController.colorWithHexString("#ffffff")
        self.nameTextField.textAlignment = .Center
        self.nameTextField.delegate = self
        self.view!.addSubview(self.nameTextField)
        
        self.saveScoreButton = UIButton(frame: CGRect(x: xMid - 150.00, y: yMid + 60, width: 300.00, height: 55.00))
        self.saveScoreButton.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.saveScoreButton.setTitle("Save", forState: UIControlState.Normal)
        self.saveScoreButton.titleLabel!.font = UIFont(name: "Copperplate", size: 30.00)
        self.saveScoreButton.addTarget(self, action: "saveName:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(saveScoreButton)
        
        self.successMsgLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.successMsgLabel.fontSize = 23
        self.successMsgLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.successMsgLabel.text = "Enter your name to save your score."
        GameViewController.adjustLabelFontSizeToFitRect(self.successMsgLabel, rect: self.scene!.frame, ratio: 2)
        self.successMsgLabel.name = "successMsgLabel"
        self.successMsgLabel.position = CGPoint(x: xMid, y:  yMid + 50)
        self.addChild(self.successMsgLabel)
        
        self.newScoreLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.newScoreLabel.fontSize = 23
        self.newScoreLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.newScoreLabel.text = "\(currentPlayer.scoreToString())"
        GameViewController.adjustLabelFontSizeToFitRect(self.newScoreLabel, rect: self.scene!.frame, ratio: 3.5)
        self.newScoreLabel.name = "newScoreLabel"
        self.newScoreLabel.position = CGPoint(x: xMid, y: yMid + 90)
        self.addChild(self.newScoreLabel)
    }
    
    func saveName(sender: UIButton!){
        saveNameOfPlayer()
    }
    
    func saveNameOfPlayer(){
        if(self.nameTextField.hidden){
            showScoreTable()
        } else {
            if (self.nameTextField.text?.characters.count > 0) {
                let playerName = self.nameTextField.text!
                currentPlayer.name = playerName
                self.view!.endEditing(true)
                showScoreTable()
            } else {
                GameViewController.showOkAlert("Please enter your name", scene: self)
            }
        }
    }
    
    func showScoreTable() {
        if currentPlayer.hasNewBestScore {print("Player has a new best score!")}
        GameViewController.showTableScore(self)
    }
    
    private func showCongratForNewScore(){
        self.congratNewScoreLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.congratNewScoreLabel.fontSize = 33
        self.congratNewScoreLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.congratNewScoreLabel.text = "You have a new best score!"
        if(currentPlayer.name != nil) { self.congratNewScoreLabel.text = "\(currentPlayer.name), \(self.congratNewScoreLabel)" }
        GameViewController.adjustLabelFontSizeToFitRect(self.congratNewScoreLabel, rect: self.scene!.frame, ratio: 1.5)
        self.congratNewScoreLabel.name = "congratNewScoreLabel"
        self.congratNewScoreLabel.position = CGPoint(x: xMid, y: yMax - 80 )
        self.addChild(self.congratNewScoreLabel)
    }
    
    private func hideControls(){
        self.saveScoreButton.hidden = true
        self.successMsgLabel.hidden = true
        self.nameTextField.hidden = true
    }
    
}
