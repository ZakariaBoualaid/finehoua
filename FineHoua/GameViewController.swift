//
//  GameViewController.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/10/16.
//  Copyright (c) 2016 Zakaria Boualaid. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData
import Foundation

var mainSplash: MainSplash!
var configScene: ConfigScene!
var gameScene: GameScene!
var newPlayerScene: NewPlayerScene!
var scoreTableScene: ScoreTableScene!
var hlfScene: HLFScene!
var allPlayers:[Player] = []
var currentPlayer:Player!
var scalingFactor:Float!

class GameViewController: UIViewController {
    
    var nameTextField:UITextField!
    var yourNameLabel:SKLabelNode!
    var fineHouaLabel:SKLabelNode!
    var myAlert:UIAlertController!
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainSplash = MainSplash(fileNamed:"MainSplash")
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.frameInterval = 1
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        skView.multipleTouchEnabled = true
        mainSplash.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        mainSplash.scaleMode = .ResizeFill
        skView.presentScene(mainSplash)
    }
    
    class func startGame() {
        configScene.hidden = true
        configScene.startButton.hidden = true
        gameScene = GameScene(fileNamed: "GameScene")
        gameScene.scaleMode = .ResizeFill
        let transition:SKTransition = SKTransition.crossFadeWithDuration(1.0)
        configScene.view!.presentScene(gameScene!, transition: transition)
    }
    
    class func restartGame() {
        scoreTableScene.hidden = true
        scoreTableScene.replayGameButton.hidden = true
        scoreTableScene.showHallOfFame.hidden = true
        scoreTableScene.backToSplash.hidden = true
        let transition:SKTransition = SKTransition.crossFadeWithDuration(1.0)
        scoreTableScene.view!.presentScene(gameScene!, transition: transition)
    }
    
    class func showHallOfFame(scene: SKScene){
        scoreTableScene.hidden = true
        scoreTableScene.replayGameButton.hidden = true
        scoreTableScene.showHallOfFame.hidden = true
        scoreTableScene.backToSplash.hidden = true
        hlfScene = HLFScene(fileNamed: "HLFScene")
        hlfScene.scaleMode = .ResizeFill
        let transition = SKTransition.fadeWithDuration(0.15)
        scene.view!.presentScene(hlfScene!, transition: transition)
    }
    
    class func showTableScore(scene: SKScene){
        newPlayerScene.hidden = true
        newPlayerScene.nameTextField.hidden = true
        newPlayerScene.saveScoreButton.hidden = true
        scoreTableScene = ScoreTableScene(fileNamed: "ScoreTableScene")
        scoreTableScene.scaleMode = .ResizeFill
        let transition = SKTransition.fadeWithDuration(0.15)
        scene.view!.presentScene(scoreTableScene!, transition: transition)
    }

    class func backToSplash(scene: SKScene){
        newPlayerScene.nameTextField.hidden = true
        newPlayerScene.saveScoreButton.hidden = true
        scoreTableScene.showHallOfFame.hidden = true
        scoreTableScene.backToSplash.hidden = true
        newPlayerScene.hidden = true
        mainSplash = MainSplash(fileNamed: "MainSplash")
        mainSplash.scaleMode = .ResizeFill
        scene.view!.presentScene(mainSplash)
    }
    
    class func sortAllPlayersByBestScore() -> [Player] {
        print("All Players Before : \(allPlayers.debugDescription)")
        
        allPlayers.sortInPlace { (Player1, Player2) -> Bool in
            return Player1.bestScore > Player2.bestScore
        }
        
        print("All Players After : \(allPlayers.debugDescription)")
        return allPlayers
    }

    class func scalingNodeFactor(node: SKNode, rect: CGRect) -> CGFloat {
        let sf = min(rect.width / node.frame.width, rect.height / node.frame.height)
        return sf
    }
    
    class func scalingUIFactor(control: UIButton, rect: CGRect) -> CGFloat {
        let sf = min(rect.width / control.frame.width, rect.height / control.frame.height)
        return sf
    }
    
    class func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect, ratio: CGFloat) {
        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        labelNode.fontSize *= scalingFactor / ratio
    }
    
    class func formatElapsedTime(elapsedTime: CFTimeInterval) -> String {
        var labelForZero = ""
        if elapsedTime < 10 { labelForZero = "0" } else { labelForZero = "" }
        return "\(labelForZero)\(String(format: "%.2f", Float(elapsedTime)))"
    }
    
    class func showOkAlert(msg:String, scene: SKScene){
        let myAlert: UIAlertController = UIAlertController(title: "Hbess!", message: msg, preferredStyle: .Alert)
        myAlert.addAction(UIAlertAction(title: "Wakha", style: .Default, handler: nil))
        scene.view?.window?.rootViewController?.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    class func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if (cString.hasPrefix("#")) {cString = (cString as NSString).substringFromIndex(1)}
        if (cString.characters.count != 6) {return UIColor.grayColor()}
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
