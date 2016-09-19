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
                self.color = UIColor.white
            case .red:
                self.color = UIColor.red
            case .green:
                self.color = UIColor.green
            case .blue:
                self.color = UIColor.blue
            case .purple:
                self.color = UIColor.purple
            case .orange:
                self.color = UIColor.orange
            case .yellow:
                self.color = UIColor.yellow
            case .black:
                self.color = UIColor.black
            case .brown:
                self.color = UIColor.brown
            }
        }
    }
    
    init() {
        
        super.init(texture: animationTextures[0], color: UIColor.white, size: CGSize(width: 1.0, height: 1.0))
        
        self.physicsBody!.categoryBitMask = CharacterType.pajama.rawValue
        self.physicsBody!.contactTestBitMask = 0
        self.physicsBody!.collisionBitMask = 0
        self.color = UIColor.white
        self.colorBlendFactor = 1.0
        self.animate()
    }
    
    func animate() {
        let animationAction = SKAction.animate(with: animationTextures, timePerFrame: 0.3, resize: true, restore: false)
        let repeatAction = SKAction.repeatForever(animationAction)
        self.run(repeatAction)
    }
    
    // apparently we need this as of xcode 6 beta 5
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
