//
//  GameScene.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/10/16.
//  Copyright (c) 2016 Zakaria Boualaid. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var OrchestraImg:SKSpriteNode!
    var touchLocation:CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {

//        OrchestraImg = self.childNodeWithName("OrchestraImg") as! SKSpriteNode
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        touchLocation = touches.first!.locationInNode(self)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
