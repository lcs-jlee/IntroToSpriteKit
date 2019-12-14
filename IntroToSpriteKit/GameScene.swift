//
//  GameScene.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    // Background music player
    var backgroundMusic: AVAudioPlayer?
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {

        // Set the background colour
        self.backgroundColor = .black
        
//        // Get a reference to the mp3 file in the app bundle
//        let backgroundMusicFilePath = Bundle.main.path(forResource: "sleigh-bells-excerpt.mp3", ofType: nil)!
//
//        // Convert the file path string to a URL (Uniform Resource Locator)
//        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)
//
//        // Attempt to open and play the file at the given URL
//        do {
//            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
//            backgroundMusic?.play()
//        } catch {
//            // Do nothing if the sound file could not be played
//        }
        self.backgroundColor = NSColor(calibratedHue: 240/360, saturation: 80/100, brightness: 10/100, alpha: 1)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        //horizontal shelf
        let horizontalShelf = SKSpriteNode(imageNamed: "horizontal-shelf-red")
        horizontalShelf.position = CGPoint(x: horizontalShelf.size.width / 2, y: self.size.height / 2)
        horizontalShelf.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -400, y: 50, width: 800, height: 1))
        //self.addChild(horizontalShelf)
        
        if let snowstorm = SKEmitterNode(fileNamed: "Snow2") {

            snowstorm.position = CGPoint(x: self.size.width / 2, y: self.size.height)
            self.addChild(snowstorm)

        }
        
        for x in 0...8 {
            let tile = SKSpriteNode(imageNamed: "tile")
            tile.position = CGPoint(x: tile.size.width / 2 + CGFloat(x) * tile.size.width, y: tile.size.height / 2)
            tile.zPosition = 2
            tile.physicsBody = SKPhysicsBody(texture: tile.texture!, alphaThreshold: 0.5, size: tile.size)
            tile.physicsBody?.isDynamic = false
            self.addChild(tile)
            
        }
        
        func addIceman() {
            let iceman = SKSpriteNode(imageNamed: "iceman")
            // Vertical position just above top of the scen
            let y = self.size.height - iceman.size.height / 2

            // Horizontal position is random
            let x = CGFloat.random(in: 0.0...self.size.width)
            
            iceman.position = CGPoint(x: x, y: y)
            
            iceman.physicsBody = SKPhysicsBody(texture: iceman.texture!, alphaThreshold: 0.5, size: iceman.size)
            
            iceman.physicsBody?.restitution = 0.5
            
            iceman.physicsBody?.mass = 20

            iceman.physicsBody?.usesPreciseCollisionDetection = true

            self.addChild(iceman)

        }
        
        
        let actionAddIceman = SKAction.run(addIceman)
        let actionWait = SKAction.wait(forDuration: 0.5)
        let sequenceAddThenWait = SKAction.sequence([actionAddIceman, actionWait])
        let actionRepeatlyAddIceman = SKAction.repeat(sequenceAddThenWait, count: 10)
        self.run(actionRepeatlyAddIceman)

        let tree = SKSpriteNode(imageNamed: "tree")
        tree.position = CGPoint(x: 150, y: 200)
        self.addChild(tree)
        
        
        let rocket = SKSpriteNode(imageNamed: "rocket")
        rocket.position = CGPoint(x: self.size.width / 2, y: 0)
        //rocket.physicsBody = SKPhysicsBody(texture: rocket.texture!,
        //                                 alphaThreshold: 0.5,
        //                                 size: rocket.size)
        self.addChild(rocket)
        //// Create an empty array of SKTexture objects
        var rocketTextures: [SKTexture] = []
        //
        //// Now add the two images we need in the array
        rocketTextures.append(SKTexture(imageNamed: "rocket_0"))
        rocketTextures.append(SKTexture(imageNamed: "rocket_1"))
        rocketTextures.append(SKTexture(imageNamed: "rocket_2"))
        rocketTextures.append(SKTexture(imageNamed: "rocket_3"))
        rocketTextures.append(SKTexture(imageNamed: "rocket_5"))


        let actionRocketAnimation = SKAction.animate(with: rocketTextures, timePerFrame: 0.4, resize: true, restore: false)

        let wait = SKAction.wait(forDuration: 3.0)
        let rocketBlastOff = SKAction.moveBy(x: 0, y: 2000, duration: 6)

        let rocketAction = SKAction.group([actionRocketAnimation, wait])

        let goUp = SKAction.sequence([rocketAction, rocketBlastOff])

        rocket.run(goUp)
        
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
