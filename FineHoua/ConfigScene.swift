//
//  ConfigScene.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/11/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

var gameDifficulty:String?
var applauseSound: AVAudioPlayer!

class ConfigScene: SKScene {
    
    var gameDescLabel:SKLabelNode!
    @IBOutlet var startButton:UIButton!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        configScene = self
        showControls()
        do {
            let sounds = ["applause"]
            for sound in sounds {
                applauseSound = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(sound, ofType: "mp3")!))
                applauseSound.prepareToPlay()
            }
        } catch {
            print("Error while loading sounds.")
        }
    }
    
    override func willMoveFromView(view: SKView) {
        self.scene!.scaleMode = .ResizeFill
    }
    
    private func showControls(){
        self.gameDescLabel = SKLabelNode(fontNamed: "Futura-Medium")
        self.gameDescLabel.fontSize = 23
        self.gameDescLabel.color = GameViewController.colorWithHexString("#ffffff")
        self.gameDescLabel.text = "The goal is to find Nicolas Cage. Click Ready when you're ready."
        GameViewController.adjustLabelFontSizeToFitRect(self.gameDescLabel, rect: self.scene!.frame, ratio: 1.1)
        self.gameDescLabel.name = "gameDescLabel"
        self.gameDescLabel.position = CGPoint(x: xMid, y: yMid + 40)
        self.addChild(self.gameDescLabel)
        
        self.startButton = UIButton(frame: CGRect(x: xMid - 150.00, y: yMid + 20, width: 300.00, height: 55.00))
        self.startButton.backgroundColor = GameViewController.colorWithHexString("#1db954")
        self.startButton.setTitle("Ready!", forState: UIControlState.Normal)
        self.startButton.titleLabel!.font = UIFont(name: "Copperplate", size: 30.00)
        self.startButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(startButton)
    }
    
    func hideControls(){
        self.startButton.hidden = true
    }
    
    func pressed(sender: UIButton!){
        GameViewController.startGame()
    }

}
