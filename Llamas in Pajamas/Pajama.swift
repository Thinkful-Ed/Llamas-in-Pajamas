//
//  Pajama.swift
//  Llamas in Pajamas
//
//  Copyright (c) 2014 Thinkful. All rights reserved.
//

import SpriteKit

enum PajamaColor {
    case none
    case red
    case green
    case blue
    case purple
    case orange
    case yellow
    case black
    case brown
}

class Pajama : GameCharacter {
    
    let animationTextures = GameCharacter.framesFromAtlas(named: "pajama")
    
    var pajamaColor: PajamaColor = PajamaColor.none {
        didSet {
            switch pajamaColor {
            case .none:
                self.color = UIColor.whiteColor()
            case .red:
                self.color = UIColor.redColor()
            case .green:
                self.color = UIColor.greenColor()
            case .blue:
                self.color = UIColor.blueColor()
            case .purple:
                self.color = UIColor.purpleColor()
            case .orange:
                self.color = UIColor.orangeColor()
            case .yellow:
                self.color = UIColor.yellowColor()
            case .black:
                self.color = UIColor.blackColor()
            case .brown:
                self.color = UIColor.brownColor()
            }
        }
    }
    
    init() {
        
        super.init(texture: animationTextures[0], color: UIColor.whiteColor(), size: CGSizeMake(1.0, 1.0))
        
        self.physicsBody!.categoryBitMask = CharacterType.Pajama.rawValue
        self.physicsBody!.contactTestBitMask = 0
        self.physicsBody!.collisionBitMask = 0
        self.color = UIColor.whiteColor()
        self.colorBlendFactor = 1.0
        self.animate()
    }
    
    func animate() {
        let animationAction = SKAction.animateWithTextures(animationTextures, timePerFrame: 0.3, resize: true, restore: false)
        let repeatAction = SKAction.repeatActionForever(animationAction)
        self.runAction(repeatAction)
    }
    
    // apparently we need this as of xcode 6 beta 5
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}