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

var player:Player!
var xMid:CGFloat!
var yMid:CGFloat!
var xMax:CGFloat!
var yMax:CGFloat!
var appBgColor:String! = "#19191a"
var appBgColorGame:String! = "#000000"

class MainSplash: SKScene, UITextFieldDelegate {
    
    @IBOutlet var startGameButton:UIButton!
    @IBOutlet var nameTextField:UITextField!
    var fineHouaLabel:SKLabelNode!
    var refreshAlert:UIAlertController!
    
    private func initVars(){
        xMid = CGRectGetMidX(self.scene!.frame)
        yMid = CGRectGetMidY(self.scene!.frame)
        xMax = CGRectGetMaxX(self.scene!.frame)
        yMax = CGRectGetMaxY(self.scene!.frame)
    }

    override func didMoveToView(view: SKView) {
        self.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        initVars()
        showControls()
    }
    
    private func showControls(){
        // Game Title & Label
        self.fineHouaLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.fineHouaLabel.fontSize = 66
        self.fineHouaLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.fineHouaLabel.text = "Fine Houa Nicolas"
        self.fineHouaLabel.name = "fineHouaLabel"
        GameViewController.adjustLabelFontSizeToFitRect(self.fineHouaLabel, rect: self.scene!.frame, ratio: 2.00)
        self.fineHouaLabel.position = CGPoint(x: xMid, y: yMax - 100.00)
        self.addChild(self.fineHouaLabel)
        
        self.nameTextField = UITextField(frame: CGRect(x: xMid - 150.00, y: yMid - 50, width: 300.00, height: 55.00))
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Your name", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.nameTextField.textColor = UIColor.whiteColor()
        self.nameTextField.font = UIFont(name: "Futura-Medium", size: 20.00)
        self.nameTextField.backgroundColor = GameViewController.colorWithHexString("#232323")
        self.nameTextField.tintColor = GameViewController.colorWithHexString("#ffffff")
        self.nameTextField.textAlignment = .Center
        self.nameTextField.delegate = self
        self.nameTextField.becomeFirstResponder()
        self.view!.addSubview(nameTextField)
        
        self.startGameButton = UIButton(frame: CGRect(x: xMid - 150.00, y: yMid + 20, width: 300.00, height: 55.00))
        self.startGameButton.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.startGameButton.setTitle("Ready!", forState: UIControlState.Normal)
        self.startGameButton.titleLabel!.font = UIFont(name: "Copperplate", size: 25.00)
        self.startGameButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        GameViewController.adjustButtonWidthToFitRect(self.startGameButton, rect: self.scene!.frame, ratio: 1)
        self.view!.addSubview(startGameButton)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return startGame()
    }
    
    func pressed(sender: UIButton!){
        startGame()
    }
    
    private func startGame() -> Bool {
        if(self.nameTextField.text?.characters.count > 0){
            let playerName = self.nameTextField.text!
            player = Player(name: playerName)
            self.view!.endEditing(true)
            hideControls()
            let configScene = ConfigScene(fileNamed: "ConfigScene")
            let transition = SKTransition.fadeWithDuration(0.15)
            self.view!.presentScene(configScene!, transition: transition)
            return true
        }
        showOkAlert("Enter your name first")
        return false
    }
    
    private func showOkAlert(msg:String){
        let myAlert: UIAlertController = UIAlertController(title: "Hbess!", message: msg, preferredStyle: .Alert)
        myAlert.addAction(UIAlertAction(title: "Wakha", style: .Default, handler: nil))
        self.view?.window?.rootViewController?.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    private func hideControls(){
        self.startGameButton.hidden = true
        self.nameTextField.hidden = true
    }

}
