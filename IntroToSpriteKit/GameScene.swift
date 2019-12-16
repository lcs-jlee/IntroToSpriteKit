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
    // Green colour
    let treeGreen = NSColor(calibratedRed: 42/255, green: 185/255, blue: 79/255, alpha: 1)
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {

        // Set the background colour
        self.backgroundColor = .black
        
        
        // Get a reference to the mp3 file in the app bundle
        let backgroundMusicFilePath = Bundle.main.path(forResource: "sleigh-bells-excerpt.mp3", ofType: nil)!

        // Convert the file path string to a URL (Uniform Resource Locator)
        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)

        // Attempt to open and play the file at the given URL
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
            backgroundMusic?.play()
        } catch {
            // Do nothing if the sound file could not be played
        }
        
        self.backgroundColor = NSColor(calibratedHue: 240/360, saturation: 80/100, brightness: 10/100, alpha: 1)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
       //create snow storm
        if let snowstorm = SKEmitterNode(fileNamed: "Snow2") {
            snowstorm.position = CGPoint(x: self.size.width / 2, y: self.size.height)
            self.addChild(snowstorm)
            
        }
        
        //create tile at the bottom
        for x in 0...8 {
            let tile = SKSpriteNode(imageNamed: "tile")
            tile.position = CGPoint(x: tile.size.width / 2 + CGFloat(x) * (tile.size.width - 10), y: tile.size.height / 2)
            tile.zPosition = 2
            tile.physicsBody = SKPhysicsBody(texture: tile.texture!, alphaThreshold: 0.5, size: tile.size)
            tile.physicsBody?.isDynamic = false
            self.addChild(tile)
            
        }
        
        //function that adds iceman
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
        
        //take care of latters
        let wait6seconds = SKAction.wait(forDuration: 6.0)
        let wait8halfseconds = SKAction.wait(forDuration: 8.5)
        
        //MC: Merry Christmas
        let addMC = SKAction.run(addMerryChristmas)
        //ST: Safe Travel
        let addST  = SKAction.run(addSafeTravel)
        
        let waitAndAddMC = SKAction.sequence([wait6seconds, addMC])
        let waitAndAddST = SKAction.sequence([wait8halfseconds, addST])
        
        self.run(waitAndAddMC)
        self.run(waitAndAddST)
        
        //take care of end credit
        let waitTwelveSeconds = SKAction.wait(forDuration: 12.0)
        let endCredit = SKAction.run(removeEverythingThenShowEndCredits)
        let prepareEndCredit = SKAction.sequence([waitTwelveSeconds,endCredit])
        self.run(prepareEndCredit)
        
        //add iceman
        let actionAddIceman = SKAction.run(addIceman)
        let actionWait = SKAction.wait(forDuration: 0.5)
        let sequenceAddThenWait = SKAction.sequence([actionAddIceman, actionWait])
        let actionRepeatlyAddIceman = SKAction.repeat(sequenceAddThenWait, count: 10)
        self.run(actionRepeatlyAddIceman)

        //add tree
        let tree = SKSpriteNode(imageNamed: "tree")
        tree.position = CGPoint(x: 150, y: 200)
        self.addChild(tree)
        
        //function that adds rocket
        func addRocket() {
            let rocket = SKSpriteNode(imageNamed: "rocket")
            let x = CGFloat.random(in: 0.0...self.size.width)
            rocket.position = CGPoint(x: x , y: 0)
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
            rocketTextures.append(SKTexture(imageNamed: "rocket_4"))
            rocketTextures.append(SKTexture(imageNamed: "rocket_5"))
            
            let actionRocketAnimation = SKAction.animate(with: rocketTextures, timePerFrame: 0.4, resize: true, restore: false)
            let wait = SKAction.wait(forDuration: 3.0)
            let rocketBlastOff = SKAction.moveBy(x: 0, y: 2000, duration: 6)
            let rocketAction = SKAction.group([actionRocketAnimation, wait])
            let goUp = SKAction.sequence([rocketAction, rocketBlastOff])

            rocket.run(goUp)
        }
        
        //add rocket
        let actionAddRocket = SKAction.run(addRocket)
        let sequenceAddRocket = SKAction.sequence([actionAddRocket, actionWait])
        let actionRepeatlyAddRocket = SKAction.repeat(sequenceAddRocket, count: 10)
        
        //add deer
        let deer = SKSpriteNode(imageNamed: "deer")
        deer.position = CGPoint(x: 0, y: 0)
        self.addChild(deer)
        
        //array for walking animation of deer
        var walkingTextures: [SKTexture] = []

        walkingTextures.append(SKTexture(imageNamed: "deer_1"))
        walkingTextures.append(SKTexture(imageNamed: "deer_2"))
        walkingTextures.append(SKTexture(imageNamed: "deer_3"))
        walkingTextures.append(SKTexture(imageNamed: "deer_4"))
        walkingTextures.append(SKTexture(imageNamed: "deer_5"))
        
        //action for deer
        let actionWalkingAnimation = SKAction.animate(with: walkingTextures, timePerFrame: 0.05, resize: true, restore: true)
        let actionMoveForward = SKAction.moveBy(x: 15, y: 0, duration: 0.1)
        let actionMoveUp = SKAction.moveBy(x: 0, y: 15, duration: 0.1)
        let actionBothWay = SKAction.group([actionMoveForward, actionMoveUp])
        let actionWalkAndMove = SKAction.group([actionWalkingAnimation, actionBothWay])
        let actionWalkAndMoveFiveTimes = SKAction.repeat(actionWalkAndMove, count: 60)
        
        deer.run(actionWalkAndMoveFiveTimes)
        
        //repeatly add rocket
        self.run(actionRepeatlyAddRocket)
        
    }
    
    //end credit
    func removeEverythingThenShowEndCredits() {
        
        // Remove all existing children nodes
        self.removeAllChildren()
        
        // Change background to black
        self.backgroundColor = .black
        
        // Add end credits
        
        // By...
        let by = SKLabelNode(fontNamed: "Helvetica Neue")
        by.fontSize = 48
        by.fontColor = .white
        by.text = "Brought to you by Mr. Lee (Jeewoo)"
        by.zPosition = 3
        by.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 50)
        self.addChild(by)
        
        // And...
        let and = SKLabelNode(fontNamed: "Helvetica Neue")
        and.fontSize = 36
        and.fontColor = .white
        and.text = "and the Grade 12 Computer Science class"
        and.zPosition = 3
        and.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 50)
        self.addChild(and)
        
    }
    
    // "Merry Christmas"
    func addMerryChristmas() {

        // Make a merry christmas text
        let merry = SKLabelNode(fontNamed: "Zapfino")
        merry.fontSize = 60
        merry.fontColor = .red
        merry.text = "Merry"
        merry.zPosition = 3
        merry.position = CGPoint(x: self.size.width / 2 - 185, y: self.size.height / 2 + 100)
        merry.alpha = 0
        self.addChild(merry)
        
        let christmas = SKLabelNode(fontNamed: "Zapfino")
        christmas.fontSize = 60
        christmas.fontColor = treeGreen
        christmas.text = "Christmas"
        christmas.zPosition = 3
        christmas.position = CGPoint(x: self.size.width / 2 + 145, y: self.size.height / 2 + 100)
        christmas.alpha = 0
        self.addChild(christmas)
        
        // Fade the warning in
        let actionFadeIn = SKAction.fadeIn(withDuration: 1.0)
        merry.run(actionFadeIn)
        christmas.run(actionFadeIn)

    }
    
    // "Sage Travel"
    func addSafeTravel() {
        let safeTravel = SKLabelNode(fontNamed: "Zapfino")
        safeTravel.fontSize = 32
        safeTravel.fontColor = .white
        safeTravel.text = "... AND Safe Travel"
        safeTravel.zPosition = 3
        safeTravel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 20)
        safeTravel.alpha = 0
        self.addChild(safeTravel)
        let actionFadeIn = SKAction.fadeIn(withDuration: 1.0)
        safeTravel.run(actionFadeIn)
    }
    
    
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
