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
        
        for x in 0...6 {
            let tile = SKSpriteNode(imageNamed: "tile")
            tile.position = CGPoint(x: tile.size.width / 2 + CGFloat(x) * tile.size.width, y: tile.size.height / 2)
            tile.zPosition = 2
            tile.physicsBody = SKPhysicsBody(texture: tile.texture!, alphaThreshold: 0.5, size: tile.size)

            self.addChild(tile)
            
        }
        
        func addIceman() {
            let iceman = SKSpriteNode(imageNamed: "iceman")
            // Vertical position just above top of the scen
            let y = self.size.height - iceman.size.height

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
        tree.position = CGPoint(x: 100, y: 0)
        self.addChild(tree)
        
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
