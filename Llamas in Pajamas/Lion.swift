//
//  Lion.swift
//  Llamas in Pajamas
//
//  Copyright (c) 2014 Thinkful. All rights reserved.
//

import SpriteKit

class Lion : GameCharacter {
    
    let animationTextures = GameCharacter.framesFromAtlas(named: "lion")
    var runningSpeedInSeconds = 0.0
    
    init(runningSpeedInSeconds: Double) {
        super.init(texture: animationTextures[0], color: UIColor.whiteColor(), size: CGSizeMake(1.0, 1.0))
        self.runningSpeedInSeconds = runningSpeedInSeconds
        self.zPosition = 2
        self.physicsBody!.categoryBitMask = CharacterType.Lion.rawValue
        self.physicsBody!.contactTestBitMask = 0
        self.physicsBody!.collisionBitMask = CharacterType.Edge.rawValue | CharacterType.Llama.rawValue | CharacterType.Pajama.rawValue
        self.physicsBody!.restitution = 0.6
        
        self.animate()
    }
    
    func animate() {
        let animateAction = SKAction.animateWithTextures(animationTextures, timePerFrame: 0.2, resize: true, restore: false)
        let moveRightAction = SKAction.moveBy(CGVector(dx: 190.0,dy: 0), duration: runningSpeedInSeconds)
        moveRightAction.timingMode = SKActionTimingMode.EaseInEaseOut
        let moveLeftAction = SKAction.moveBy(CGVector(dx: -190.0,dy: 0), duration: runningSpeedInSeconds*2)
        moveLeftAction.timingMode = SKActionTimingMode.EaseInEaseOut
        let moveSequence = SKAction.sequence([moveRightAction, moveLeftAction])
        let group = SKAction.group([animateAction,moveSequence])
        let repeatAction = SKAction.repeatActionForever(group)
        self.runAction(repeatAction, withKey: "lionRun")
    }
    
    //apparently we need this as of xcode 6 beta 5
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}