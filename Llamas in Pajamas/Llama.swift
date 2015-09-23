//
//  Llama.swift
//  Llamas in Pajamas
//
//  Copyright (c) 2014 Thinkful. All rights reserved.
//

import SpriteKit

class Llama : GameCharacter {
    
    var points: Int = 0
    var health: Int = 100 {
        didSet {
            if health >= 50 {
                // if health is set to 50 or higher, remove pulse
                removePulse()
            }
        }
    }
    
    let idleAnimationTextures = GameCharacter.framesFromAtlas(named: "llama-idle")
    let walkAnimationTextures = GameCharacter.framesFromAtlas(named: "llama-walk")
    
    init() {
        
        super.init(texture: self.idleAnimationTextures[0], color: UIColor.whiteColor(), size: CGSizeMake(1.0, 1.0))
        
        self.physicsBody!.categoryBitMask = CharacterType.Llama.rawValue
        self.physicsBody!.contactTestBitMask = CharacterType.Pajama.rawValue | CharacterType.Lion.rawValue
        self.physicsBody!.collisionBitMask = CharacterType.Edge.rawValue
        self.physicsBody!.linearDamping = 1.5
        self.physicsBody!.restitution = 0.1
        self.animateIdle()
    }
    
    func animateIdle() {
        let animationAction = SKAction.animateWithTextures(self.idleAnimationTextures, timePerFrame: 0.05, resize: true, restore: false)
        let repeatAction = SKAction.repeatActionForever(animationAction)
        self.runAction(repeatAction)
    }
    
    func animateWalk(duration: Int) {
        let animationAction = SKAction.animateWithTextures(self.walkAnimationTextures, timePerFrame: 0.05, resize: true, restore: false)
        let repeatAction = SKAction.repeatAction(animationAction, count: duration)
        self.runAction(repeatAction, completion: animateIdle)
    }
    
    func pulse() {
        if let _ = self.actionForKey("pulse") {
            print("Already pulsing!")
        } else {
            let pulseRed = SKAction.sequence([
                SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.55),
                SKAction.waitForDuration(0.1),
                SKAction.colorizeWithColorBlendFactor(0.0, duration: 0.55)])
            let repeatAction = SKAction.repeatActionForever(pulseRed)
            self.runAction(repeatAction, withKey:"pulse")
        }
    }
    
    func removePulse() {
        self.removeActionForKey("pulse")
        self.colorBlendFactor = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
