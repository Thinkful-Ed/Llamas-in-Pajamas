//
//  GameCharacter.swift
//  Llamas in Pajamas
//
//  Copyright (c) 2014 Thinkful. All rights reserved.
//

import SpriteKit

enum CharacterType: UInt32 {
    case Llama
    case Pajama
    case Lion
    case Edge
}

class GameCharacter: SKSpriteNode {
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        
        self.xScale = 0.4 // 0.5 for retina only images... slighlty smaller to make gameplay better
        self.yScale = 0.4
        self.physicsBody = SKPhysicsBody(circleOfRadius: 25) // why 25?
        self.physicsBody!.dynamic = true
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.restitution = 1.0
        self.physicsBody!.friction = 0
        self.physicsBody!.linearDamping = 0
        self.physicsBody!.angularDamping = 0
    }
    
    //this is necessary to sort the images correctly
    class func framesFromAtlas(named atlasName: String) -> [SKTexture] {
        let atlas = SKTextureAtlas(named: atlasName)
        
        var textureNames = atlas.textureNames as! [String]
        
        sort(&textureNames, { $0 < $1 } )
        
        let textures = textureNames.map {
            textureName -> SKTexture in
            return atlas.textureNamed(textureName as String)
        }
        
        return textures
    }

    //apparently we need this as of xcode 6 beta 5
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
