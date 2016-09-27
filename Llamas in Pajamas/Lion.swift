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
        super.init(texture: animationTextures[0], color: UIColor.white, size: CGSize(width: 1.0, height: 1.0))
        self.runningSpeedInSeconds = runningSpeedInSeconds
        self.zPosition = 2
        self.physicsBody!.categoryBitMask = CharacterType.lion.rawValue
        self.physicsBody!.contactTestBitMask = 0
        self.physicsBody!.collisionBitMask = CharacterType.edge.rawValue | CharacterType.llama.rawValue | CharacterType.pajama.rawValue
        self.physicsBody!.restitution = 0.6
        
        self.animate()
    }
    
    func animate() {
        let animateAction = SKAction.animate(with: animationTextures, timePerFrame: 0.2, resize: true, restore: false)
        let moveRightAction = SKAction.move(by: CGVector(dx: 190.0,dy: 0), duration: runningSpeedInSeconds)
        moveRightAction.timingMode = SKActionTimingMode.easeInEaseOut
        let moveLeftAction = SKAction.move(by: CGVector(dx: -190.0,dy: 0), duration: runningSpeedInSeconds*2)
        moveLeftAction.timingMode = SKActionTimingMode.easeInEaseOut
        let moveSequence = SKAction.sequence([moveRightAction, moveLeftAction])
        let group = SKAction.group([animateAction,moveSequence])
        let repeatAction = SKAction.repeatForever(group)
        self.run(repeatAction, withKey: "lionRun")
    }
    
    //apparently we need this as of xcode 6 beta 5
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
