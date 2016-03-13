//
//  hallOfFameScene.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/13/16.
//  Copyright © 2016 Zakaria Boualaid. All rights reserved.
//

import UIKit
import SpriteKit

class HLFScene: SKScene {

    var tableView: UITableView!
    var labelOfFame:SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = GameViewController.colorWithHexString(appBgColor)
        showTable()
    }
    
    func showTable() {
        tableView = UITableView(frame: CGRect(x: xMid - adapt(200), y: yMid - adapt(100), width: adapt(400), height: adapt(400)), style: .Plain)
        tableView.backgroundColor = UIColor.whiteColor()
        for player in GameViewController.sortAllPlayersByBestScore() {
            print("Listing ! \(player.name)")
        }
        self.view!.addSubview(tableView)
        
        self.labelOfFame = SKLabelNode(fontNamed: "Futura-Medium")
        self.labelOfFame.fontSize = 33
        self.labelOfFame.color = GameViewController.colorWithHexString("#ffffff")
        self.labelOfFame.text = "Hall Of Fame"
        GameViewController.adjustLabelFontSizeToFitRect(self.labelOfFame, rect: self.scene!.frame, ratio: 1.5)
        self.labelOfFame.name = "labelOfFame"
        self.labelOfFame.position = CGPoint(x: xMid, y: yMax - adapt(120))
        self.addChild(self.labelOfFame)
    }
    
    func adapt(f: CGFloat) -> CGFloat {
        return self.view!.frame.width / (1024 / f)
    }

}
