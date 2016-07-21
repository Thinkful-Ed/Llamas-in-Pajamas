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
        
        super.init(texture: self.idleAnimationTextures[0], color: UIColor.white(), size: CGSize(width: 1.0, height: 1.0))
        
        self.physicsBody!.categoryBitMask = CharacterType.llama.rawValue
        self.physicsBody!.contactTestBitMask = CharacterType.pajama.rawValue | CharacterType.lion.rawValue
        self.physicsBody!.collisionBitMask = CharacterType.edge.rawValue
        self.physicsBody!.linearDamping = 1.5
        self.physicsBody!.restitution = 0.1
        self.animateIdle()
    }
    
    func animateIdle() {
        let animationAction = SKAction.animate(with: self.idleAnimationTextures, timePerFrame: 0.05, resize: true, restore: false)
        let repeatAction = SKAction.repeatForever(animationAction)
        self.run(repeatAction)
    }
    
    func animateWalk(_ duration: Int) {
        let animationAction = SKAction.animate(with: self.walkAnimationTextures, timePerFrame: 0.05, resize: true, restore: false)
        let repeatAction = SKAction.repeat(animationAction, count: duration)
        self.run(repeatAction, completion: animateIdle)
    }
    
    func pulse() {
        if let _ = self.action(forKey: "pulse") {
            print("Already pulsing!")
        } else {
            let pulseRed = SKAction.sequence([
                SKAction.colorize(with: UIColor.red(), colorBlendFactor: 1.0, duration: 0.55),
                SKAction.wait(forDuration: 0.1),
                SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.55)])
            let repeatAction = SKAction.repeatForever(pulseRed)
            self.run(repeatAction, withKey:"pulse")
        }
    }
    
    func removePulse() {
        self.removeAction(forKey: "pulse")
        self.colorBlendFactor = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
