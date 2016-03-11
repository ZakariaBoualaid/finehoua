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

class GameViewController: UIViewController {
    
    var nameTextField:UITextField!
    var yourNameLabel:SKLabelNode!
    var fineHouaLabel:SKLabelNode!
    var myAlert:UIAlertController!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = MainSplash(fileNamed:"MainSplash") {
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            skView.backgroundColor = GameViewController.colorWithHexString(appBgColor)
            scene.backgroundColor = GameViewController.colorWithHexString(appBgColor)
            scene.scaleMode = .ResizeFill
            skView.presentScene(scene)
        }
    }
    
    class func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect, ratio: CGFloat) {
        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        labelNode.fontSize *= scalingFactor / ratio
    }
    
    class func adjustButtonWidthToFitRect(button:UIButton, rect:CGRect, ratio: CGFloat) {
        let scalingFactor = min(rect.width / button.frame.width, rect.height / button.frame.height)
        //button.titleLabel!.sizeThatFits(CGSize(width: rect.width, height: rect.height))
        //button.titleLabel!.sizeToFit()
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
