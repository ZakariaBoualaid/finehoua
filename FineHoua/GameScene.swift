//
//  GameScene.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/10/16.
//  Copyright (c) 2016 Zakaria Boualaid. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var arrayImages:[String] = ["orchestraImg", "malysiaImg"]
    var randomImage:SKSpriteNode!
    var touchLocation:CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {
        //self.view!.scene!.scaleMode = .AspectFill
        self.backgroundColor = GameViewController.colorWithHexString(appBgColorGame)
        showImage()
    }
    
    private func showImage(){
        let arrayImagesMaxIndex = arrayImages.count - 1
        let randomIndex = RandomInt(min: 0, max: arrayImagesMaxIndex)
        randomImage = SKSpriteNode(texture: SKTexture(imageNamed: "\(arrayImages[randomIndex])"))
        randomImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        randomImage.position = CGPoint(x: xMid, y: yMid)
        self.addChild(randomImage)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchLocation = touches.first!.locationInNode(self)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func RandomInt(min min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}
