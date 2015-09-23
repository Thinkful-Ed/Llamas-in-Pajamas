//
//  GameScene.swift
//  Llamas in Pajamas
//
//  Copyright (c) 2014 Thinkful. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playRect = CGRect()
    var llama = Llama()
    var pajamaCount = 0
    var userWonTheGame = false
    var startTime = NSDate()
    
    //MARK:- SKScene Methods
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        playRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: playRect)
        userWonTheGame = false
        startTime = NSDate()
        
        // add background
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "background"))
        background.anchorPoint = CGPointZero
        addChild(background)
        
        addCharacters()
        
        addLlama()
        
        physicsWorld.contactDelegate = self
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //MARK:- Track Touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            // Move llama to position of touch
            
            var locationInScene = touch.locationInNode(self)
            
            //don't let the llama walk into the sky because that's silly
            if locationInScene.y > playRect.size.height {
                locationInScene.y = playRect.size.height
            }
            
            let moveAction = SKAction.moveTo(locationInScene, duration: 0.8)
            moveAction.timingMode = SKActionTimingMode.EaseInEaseOut
            llama.runAction(moveAction)
            
            llama.animateWalk(1)
        }

    }
    
    //MARK:- SKPhysicsContactDelegate Methods
    
    func didBeginContact(contact: SKPhysicsContact) {
        var otherNode = SKNode()
        
        if contact.bodyA.node == llama {
            otherNode = contact.bodyB.node!
            
        } else if contact.bodyB.node == llama {
            otherNode = contact.bodyA.node!
        }
        
        if otherNode.isKindOfClass(GameCharacter) {
            self.handleLlamaCollisions(otherNode as! GameCharacter)
        }
    }
    
    //MARK:- Instance Methods
    
    func addCharacters() {
        
        // Add red pajamas
        for _ in 0..<3 {
            let pajama = Pajama()
            pajama.pajamaColor = PajamaColor.red
            addPajama(pajama)
        }
        
        // Add blue pajamas
        for _ in 0..<5 {
            let pajama = Pajama()
            pajama.pajamaColor = PajamaColor.blue
            addPajama(pajama)
        }
        
        // Add green pajamas
        for _ in 0..<4 {
            let pajama = Pajama()
            pajama.pajamaColor = PajamaColor.purple
            addPajama(pajama)
        }
        
        // Add lions
        let lion1 = Lion(runningSpeedInSeconds: 1.2)
        lion1.position = CGPointMake(60, 100)
        addChild(lion1)
        
        let lion2 = Lion(runningSpeedInSeconds: 0.9)
        lion2.position = CGPointMake(60, 200)
        addChild(lion2)
        
        let lion3 = Lion(runningSpeedInSeconds: 0.6)
        lion3.position = CGPointMake(60, 300)
        addChild(lion3)
    }
    
    func addPajama(pajama: Pajama) {
        let randomX = CGFloat(arc4random() % UInt32(playRect.width))
        let randomY = CGFloat(arc4random() % UInt32(playRect.height))
        pajama.position = CGPointMake(randomX, randomY)
        addChild(pajama)
        pajamaCount++
    }
    
    func addLlama() {
        llama.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+110)
        addChild(llama)
    }
    
    func handleLlamaCollisions(character: GameCharacter) {
        
        if character.isKindOfClass(Lion) {
            lionContacted(character as! Lion)
        } else if character.isKindOfClass(Pajama) {
            pajamaContacted(character as! Pajama)
        }
    }
    
    func lionContacted(lion: Lion) {
        
        llama.health -= 10
        
        print("Llama health is now \(llama.health)")
        
        if llama.health < 50 {
            llama.pulse()
        }
        
        if llama.health <= 0 {
            showGameOverMessage()
        }
    }
    
    func pajamaContacted(pajama: Pajama) {
        
        // update the score based on pajama color
        switch pajama.pajamaColor {
        case .red:
            llama.points += 20
        case .green:
            llama.points += 10
        case .blue:
            llama.points += 5
        case .purple:
            llama.points += 2
        case .orange:
            llama.points += 1
        case .yellow:
            llama.points += 1
        case .black:
            llama.points += 1
        case .brown:
            llama.points += 1
        case .none:
            llama.points += 1
        }
        
        // make pajama disappear
        pajama.removeFromParent()
        
        // update count of pajamas remaining
        pajamaCount--
        
        print("Llama now has \(llama.points) points and \(pajamaCount) pajamas remaining")
        
        if pajamaCount == 0 {
            userWonTheGame = true
            showGameOverMessage()
        }
    }
    
    func showGameOverMessage() {
        
        let currentTime = NSDate()
        let gameTime = currentTime.timeIntervalSinceDate(startTime)
        print("Game completed in \(gameTime) seconds")
        if userWonTheGame == true {
            print("You Won!")
        } else {
            print("You Lost!")
        }
        
        // set delegate to nil so that gameplay is essentially over
        self.physicsWorld.contactDelegate = nil
        
        let gameOverAlert = UIAlertController(title: userWonTheGame ? "You Won!" : "You Lost!",
            message: userWonTheGame ? "Great job!" : "Sorry!",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        gameOverAlert.addAction(UIAlertAction(title: "Restart",
            style: UIAlertActionStyle.Default, handler: restartGame))
        
        self.view?.window?.rootViewController?.presentViewController(gameOverAlert, animated: true, completion: nil)
    }
    
    func restartGame(sender: UIAlertAction?) {
        for child: AnyObject in self.children {
            if child.isKindOfClass(GameCharacter) {
                child.removeFromParent()
            }
        }
        
        // set delegate to self again so we can handle collisions
        self.physicsWorld.contactDelegate = self
        
        pajamaCount = 0
        userWonTheGame = false
        startTime = NSDate()
        
        addCharacters()
        
        llama.health = 100
        llama.points = 0
        addLlama()
        
        print("New Game!")
    }
    
}
