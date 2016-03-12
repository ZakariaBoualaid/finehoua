//
//  GameScene.swift
//  FineHoua
//
//  Created by Zakaria Boualaid on 3/10/16.
//  Copyright (c) 2016 Zakaria Boualaid. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var arrayImages:[(imgName: String, nicolasCagePos: CGPoint)] =
    [(imgName: "orchestraImg", nicolasCagePos: CGPoint(x: 362.00, y: 338.00)),
    (imgName: "malysiaImg", nicolasCagePos: CGPoint(x: 499.0, y: 592.0))]
    
    var randomImage:SKSpriteNode!
    var randomIndex:Int!
    var touchLocation:CGPoint = CGPointZero
    var timeOfLastFailedTouch: CFTimeInterval?
    var startingTime: CFTimeInterval!
    var elapsedTime: CFTimeInterval!
    var emptyNode: SKSpriteNode!
    var pinchRec = UIPinchGestureRecognizer()
    var swipeRec = UISwipeGestureRecognizer()
    
    override func didMoveToView(view: SKView) {
        gameScene = self
        self.backgroundColor = GameViewController.colorWithHexString(appBgColorGame)
        pinchRec = UIPinchGestureRecognizer(target:self, action:"pinchDetected:")
        self.view!.addGestureRecognizer(pinchRec)
        showImage()
    }
    
    override func willMoveFromView(view: SKView) {
        print("\(self.view!.frame.height), \(self.view!.frame.width)")
//        print("Player Score: \(currentPlayer.scoreToString())")
    }
    
    private func showImage(){
        if(randomImage != nil) {self.removeChildrenInArray([randomImage])}
        let arrayImagesMaxIndex = arrayImages.count - 1
        randomIndex = RandomInt(min: 0, max: arrayImagesMaxIndex)
        randomImage = SKSpriteNode(texture: SKTexture(imageNamed: "\(arrayImages[randomIndex].imgName)"))
        randomImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        randomImage.size = self.view!.frame.size
        randomImage.position = CGPoint(x: xMid, y: yMid)
        self.addChild(randomImage)
        startingTime = CACurrentMediaTime()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.count == 1 {
            print("\(touchLocation.x) , \(touchLocation.y)")
            touchLocation = touches.first!.locationInNode(self)
            let x = self.view!.frame.width / (1024.00 / arrayImages[randomIndex].nicolasCagePos.x)
            let y = self.view!.frame.height / (768.00 / arrayImages[randomIndex].nicolasCagePos.y)
            if (((touchLocation.x - 50)...(touchLocation.x + 50)).contains(x)
                && ((touchLocation.y - 50)...(touchLocation.y + 50)).contains(y)) {
                    if timeOfLastFailedTouch == nil || touches.first!.timestamp - timeOfLastFailedTouch! > 2 {
                        currentPlayer.setNewScore(Float(elapsedTime))
                        applauseSound.play()
                        nicolasCageIsFound()
                    } else { print("Nice! But the player is cheating by touching everywhere!!") }
            } else {
                timeOfLastFailedTouch = touches.first!.timestamp
            }
        } else if touches.count == 2 {
            
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    func pinchDetected(pinchRecognizer: UIPinchGestureRecognizer) {
        let scale: CGFloat = pinchRecognizer.scale;
        print(scale)
        //randomImage.setScale(scale)
        self.view!.transform = CGAffineTransformScale(self.view!.transform, scale, scale);
        pinchRecognizer.scale = 1.0;
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touch ended !")
        //pinchRec.scale = 0.5;
        //randomImage.setScale(1.0)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("Touch cancelled !")
    }
    
    private func nicolasCageIsFound(){
        print("Nicolas Cage is Found by the player!!")
        if (currentPlayer.isNewPlayer()) {
            newPlayerScene = NewPlayerScene(fileNamed: "NewPlayerScene")
            newPlayerScene.scaleMode = .ResizeFill
            let transition = SKTransition.fadeWithDuration(0.1)
            self.view!.presentScene(newPlayerScene!, transition: transition)
        } else {
            GameViewController.showTableScore(self)
        }
    }
   
    // 60 FPS
    override func update(currentTime: CFTimeInterval) {
        elapsedTime = CACurrentMediaTime() - startingTime
        var labelForZero = ""
        if elapsedTime < 10 { labelForZero = "0" } else { labelForZero = "" }
        //print("Elapsed Time : \(labelForZero)\(String(format: "%.2f", elapsedTime))")
    }
    
    func RandomInt(min min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}
