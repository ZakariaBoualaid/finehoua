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
    [(imgName: "orchestraImg", nicolasCagePos: CGPoint(x: 362.00, y: 340.00)),
    (imgName: "malysiaImg", nicolasCagePos: CGPoint(x: 499.0, y: 592.0))]
    
    var randomImage:SKSpriteNode!
    var randomIndex:Int!
    var touchLocation:CGPoint = CGPointZero
    var timeOfLastFailedTouch: CFTimeInterval?
    var startingTime: CFTimeInterval!
    var elapsedTime: CFTimeInterval!
    var emptyNode: SKSpriteNode!
    var pinchRec = UIPinchGestureRecognizer()
    var panRec = UIPanGestureRecognizer()
    var originalImageScale: Float!
    var randomUIImage: UIImage!
    var randomUIImageView: UIImageView!
    var initialViewFrame: CGRect!
    var currentViewScale: CGFloat = 1.0
    
    override func didMoveToView(view: SKView) {
        print("View Description : \(self.view!.debugDescription)")
        print("Self Description : \(self.debugDescription)")
        gameScene = self
        gameScene.backgroundColor = GameViewController.colorWithHexString(appBgColorGame)
        
        initialViewFrame = self.view!.frame

        showImage()
    }
    
    override func willMoveFromView(view: SKView) {
        print("\(self.view!.frame.height), \(self.view!.frame.width)")
        print(self.view!.center)
        print("position of scene \(self.scene!.view!)")
        
        print("\(initialViewFrame)")
        self.view!.frame = initialViewFrame
        
        //self.view!.sizeToFit()
        panRec.enabled = false
        pinchRec.enabled = false
//        print("Player Score: \(currentPlayer.scoreToString())")
    }
    
    private func showImage(){
        randomImage = nil
        if(randomImage != nil) {self.removeChildrenInArray([randomImage])}
        let arrayImagesMaxIndex = arrayImages.count - 1
        randomIndex = RandomInt(min: 0, max: arrayImagesMaxIndex)
        randomImage = SKSpriteNode(texture: SKTexture(imageNamed: "\(arrayImages[randomIndex].imgName)"))
        randomImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        randomImage.size = initialViewFrame.size
        randomImage.position = CGPoint(x: xMid, y: yMid)
        //randomImage.setScale(1.0)
        //imageScrollView = ImageScrollView(frame: self.view!.frame)
        randomUIImage = UIImage(named: "\(arrayImages[randomIndex].imgName)")
        //randomUIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view!.frame.width, height: self.view!.frame.height))
        randomUIImageView = UIImageView(image: randomUIImage)
        print("UIImageView frame a : \(randomUIImageView.frame)")
        randomUIImageView.frame = CGRectMake(0, 0, self.view!.frame.width, self.view!.frame.height)
        print("UIImageView frame  b : \(randomUIImageView.frame)")
        randomUIImageView.center = self.view!.center
        print("UIImageView frame c : \(randomUIImageView.frame)")
    
        randomUIImageView.userInteractionEnabled = true
        randomUIImageView.frame.size = self.view!.frame.size
        print("randomUIImage size 1: \(randomUIImage.size)")
        print("View size 1: \(self.view!.frame.size)")
        self.view!.addSubview(randomUIImageView)
        
        pinchRec = UIPinchGestureRecognizer(target:gameScene, action:"pinchDetected:")
        randomUIImageView.addGestureRecognizer(pinchRec)
        
        panRec = UIPanGestureRecognizer(target: gameScene, action:"panDetected:")
        gameScene.view!.addGestureRecognizer(panRec)
        //self.addChild(randomImage)
        startingTime = CACurrentMediaTime()
    }
    
    func imageTapped(img: AnyObject)
    {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan at \(touches.first!.locationInNode(self)) !")
        print("\(self.view!.frame)")
        if touches.count == 1 {
//            let touchLocationInImageView = touches.first!.locationInView(randomUIImageView)
//            let touchLocationInSelfView = touches.first!.locationInView(self.view!)
            let touchLocationInNode = touches.first!.locationInNode(self)
            touchLocation.x = touchLocationInNode.x
            touchLocation.y = touchLocationInNode.y
            let x = (randomUIImageView.frame.width / currentViewScale) / (1024 / arrayImages[randomIndex].nicolasCagePos.x)
            let y = (randomUIImageView.frame.height / currentViewScale) / (768 / arrayImages[randomIndex].nicolasCagePos.y)
            if (((touchLocation.x - 50)...(touchLocation.x + 50)).contains(x)
                && ((touchLocation.y - 50)...(touchLocation.y + 50)).contains(y)) {
                    if timeOfLastFailedTouch == nil || touches.first!.timestamp - timeOfLastFailedTouch! > 2 {
                        currentPlayer.setNewScore(Float(elapsedTime))
                        applauseSound.play()
                        randomUIImageView.image = nil
                        print("origin : \(self.view!.frame.origin)")
                        nicolasCageIsFound()
                    } else { print("Nice! But the player is cheating by touching everywhere!!") }
            } else {
                print("Not right!")
                timeOfLastFailedTouch = touches.first!.timestamp
            }
        }
    }
    
    func panDetected(panRecognizer: UIPanGestureRecognizer) {
        //print(panRecognizer.debugDescription)
        let translation = panRecognizer.translationInView(self.view! )
        panRecognizer.view!.center = CGPointMake(panRecognizer.view!.center.x + translation.x, panRecognizer.view!.center.y + translation.y)
        panRecognizer.setTranslation(CGPointZero, inView: self.view!)
    }
    
    func pinchDetected(pinchRecognizer: UIPinchGestureRecognizer) {
        if pinchRecognizer.numberOfTouches() < 2{
            return;
        }
        
        let currentScale: CGFloat = pinchRecognizer.view!.layer.valueForKeyPath("transform.scale.x") as! CGFloat
        currentViewScale = currentScale
        print("pinch recognizer view : \(pinchRecognizer.view!)")
        let minScale: CGFloat = 1.0
        let maxScale: CGFloat = 3.0
        let zoomSpeed:CGFloat = 1.0
        
        var deltaScale: CGFloat = pinchRecognizer.scale
        
        deltaScale = ((deltaScale - 1) * zoomSpeed) + 1
        deltaScale = min(deltaScale, maxScale / currentScale)
        deltaScale = max(deltaScale, minScale / currentScale)
        
        print("current scale : \(currentScale)")
        print("pinsh scale : \(pinchRecognizer.scale)")
        print("delta scale : \(deltaScale)")
        print("view size : \(self.view!.frame.size)")
        print("random image size : \(randomUIImage.size)")
        print("random image view size : \(randomUIImageView.frame.size)")
        
        let zoomTransform: CGAffineTransform = CGAffineTransformScale(pinchRecognizer.view!.transform, deltaScale, deltaScale)
        pinchRecognizer.view!.transform = zoomTransform
        
        pinchRecognizer.scale = 1
        
        if pinchRecognizer.state == .Ended {
            print("pinch Ended!")
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touch ended !")
    }
    
    private func nicolasCageIsFound(){
        print("Nicolas Cage is Found by the player!!")
        if (currentPlayer.isNewPlayer()) {
            newPlayerScene = NewPlayerScene(fileNamed: "NewPlayerScene")
            newPlayerScene.scaleMode = .ResizeFill
            let transition = SKTransition.fadeWithDuration(0.1)
            self.view!.frame = initialViewFrame
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
        print("Elapsed Time : \(labelForZero)\(String(format: "%.2f", elapsedTime))")
    }
    
    func RandomInt(min min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}
