////
////  ImageScrollView.swift
////  FineHoua
////
////  Created by Zakaria Boualaid on 3/13/16.
////  Copyright © 2016 Zakaria Boualaid. All rights reserved.
////
//
//import UIKit
//import SpriteKit
//
//class ImageScrollView: UIScrollView {
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("in image scroll view controller \(touches.first!.locationInNode(gameScene))")
//        print("touchesBegan!")
//        if touches.count == 1 {
//            let touchLocationInImageView = touches.first!.locationInView(randomUIImageView)
//            let touchLocationInSelfView = touches.first!.locationInView(gameScene.view!)
//            let touchLocationInNode = touches.first!.locationInNode(gameScene)
//            let touchLocationInScrollView = touches.first!.locationInView(self)
//            touchLocation.x = touchLocationInImageView.x
//            touchLocation.y = touchLocationInImageView.y
//            print("Touch Location In Image View : \(touchLocationInImageView.x) , \(touchLocationInImageView.y)")
//            print("Touch Location In Self View : \(touchLocationInSelfView.x) , \(touchLocationInSelfView.y)")
//            print("Touch Location In Node : \(touchLocationInNode.x) , \(touchLocationInNode.y)")
//            print("Touch Location In ScrollView : \(touchLocationInScrollView.x) , \(touchLocationInScrollView.y)")
//            let x = arrayImages[randomIndex].nicolasCagePos.x
//            let y = arrayImages[randomIndex].nicolasCagePos.y
//            //let x = (randomUIImageView.frame.width) / (1024 / arrayImages[0].nicolasCagePos.x)
//            //let y = (randomUIImageView.frame.height) / (768 / arrayImages[0].nicolasCagePos.y)
//            print("x : \(x), y : \(y)")
//            if (((touchLocation.x - 50)...(touchLocation.x + 50)).contains(x)
//                && ((touchLocation.y - 50)...(touchLocation.y + 50)).contains(y)) {
//                    if gameScene.timeOfLastFailedTouch == nil || touches.first!.timestamp - gameScene.timeOfLastFailedTouch! > 2 {
//                        currentPlayer.setNewScore(Float(gameScene.elapsedTime))
//                        applauseSound.play()
//                        gameScene.nicolasCageIsFound()
//                    } else { print("Nice! But the player is cheating by touching everywhere!!") }
//            } else {
//                gameScene.timeOfLastFailedTouch = touches.first!.timestamp
//            }
//        } else if touches.count == 2 {
//            
//        }
//    }
//
//}
