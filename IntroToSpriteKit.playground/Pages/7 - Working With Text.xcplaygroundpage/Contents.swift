/*:
 ## Working With Text
 
 Immediately below is code that sets up the "hill" scene again.
 
 Read past this section of code to learn how to add text nodes into a scene.
 */

// Required frameworks
import PlaygroundSupport    // Allows playground to show live view
import SpriteKit            // Provides 2D graphics classes

// Define the animation size and scene
let frame = CGRect(x: 0, y: 0, width: 725, height: 320)
var scene = SKScene(size: frame.size)

// Define, configure, and present the scene
let view = SKView(frame: frame)
view.showsNodeCount = true
view.showsPhysics = true        // Show outlines of physics bodies
view.presentScene(scene)

// Show the view in the live view area
PlaygroundSupport.PlaygroundPage.current.liveView = view

// Create and position the hill
let hill = SKSpriteNode(imageNamed: "hill")
hill.position = CGPoint(x: hill.size.width / 2, y: hill.size.height / 2)
scene.addChild(hill)

// Add a physics body for the hill
hill.physicsBody = SKPhysicsBody(texture: hill.texture!,
                                 alphaThreshold: 0.5,
                                 size: hill.size)
hill.physicsBody?.isDynamic = false // Hill will not move (not impacted by physics)

// Make an edge loop at the boundaries of the scene
scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)

/*:
 
 ### Adding Text Nodes
 
 A piece of text is like any other node in a SpriteKit scene, just created from the `SKLabelNode` class.
 
 - Experiment:
     Uncomment the blocks of code below, one block at a time. Run the playground after uncommenting each block.
 
 - Note:
 You may wish to set the Live View area to present at the bottom of the Xcode window, since this playground creates a fairly wide SpriteKit scene:
 
 ![live-view-at-bottom](live-view-at-bottom.png)
  
 Remember that you can select a block of code by positioning your cursor at the left edge of the first line, then hold down the **Shift** key, then press the **↓** key.
  
 Once you have selected the block of code, press the **Command** and / keys at the same time to toggle the comments off all at once.

 */

//// Create a label node (must reference a font installed on the system)
let title = SKLabelNode(fontNamed: "Helvetica Neue Light")
title.fontSize = 24
title.fontColor = .orange
title.zPosition = 10        // Make sure text appears in front of other nodes
title.text = "Letter Slide"
title.position = CGPoint(x: scene.size.width - 100, y: scene.size.height - 50)
scene.addChild(title)

//// Create a letter that will fall down the slide
let letter = SKLabelNode(fontNamed: "Rockwell")
letter.fontSize = 36
letter.fontColor = .white
letter.text = "T"
letter.position = CGPoint(x: 56, y: scene.size.height - 50)
//// Physics body is just slightly above the baseline of the text
letter.physicsBody = SKPhysicsBody(circleOfRadius: 15,
                                   center: CGPoint(x: 0, y: 10))
//// Add the letter to the scene
scene.addChild(letter)

/*:
 
 The title, *Letter Slide* is created and added to the scene, but has no physics body. So it does not move nor is it affected by interactions with any other nodes.
 
 The capital letter T is created, given a circular physics body, and so it falls and interacts with the hill.
 
 ### Exercises
 
 1. Create several individual text nodes, with [rectangular physics bodies](https://developer.apple.com/documentation/spritekit/skphysicsbody/1520295-init). Line up the letters at the bottom of the hill so they look something like what is pictured below (the word and font you choose may vary). Create an animation where the letter T rolls down the hill and bumps all the other letters away.
 
 ![letter-slide](letter-slide.png)
 
 *With apologies to any New York Yankees fans in our class.*
 
 */

// Exercise 1: Write your code below.
let letterY = SKLabelNode(fontNamed: "Rockwell")
letterY.fontSize = 36
letterY.fontColor = .white
letterY.text = "y"
letterY.position = CGPoint(x: 370, y: 10)
//// Physics body is just slightly above the baseline of the text
letterY.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 18, height: 35), center: CGPoint(x: 0, y: 10))
scene.addChild(letterY)

let letterA = SKLabelNode(fontNamed: "Rockwell")
letterA.fontSize = 36
letterA.fontColor = .white
letterA.text = "a"
letterA.position = CGPoint(x: 379, y: 10)
//// Physics body is just slightly above the baseline of the text
letterA.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 18, height: 25), center: CGPoint(x: 0, y: 10))
scene.addChild(letterA)

let letterN = SKLabelNode(fontNamed: "Rockwell")
letterN.fontSize = 36
letterN.fontColor = .white
letterN.text = "n"
letterN.position = CGPoint(x: 387, y: 10)
//// Physics body is just slightly above the baseline of the text
letterN.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 18, height: 25), center: CGPoint(x: 0, y: 10))
scene.addChild(letterN)

let letterK = SKLabelNode(fontNamed: "Rockwell")
letterK.fontSize = 36
letterK.fontColor = .white
letterK.text = "k"
letterK.position = CGPoint(x: 396, y: 10)
//// Physics body is just slightly above the baseline of the text
letterK.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 18, height: 32), center: CGPoint(x: 0, y: 10))
scene.addChild(letterK)

let letterE = SKLabelNode(fontNamed: "Rockwell")
letterE.fontSize = 36
letterE.fontColor = .white
letterE.text = "e"
letterE.position = CGPoint(x: 405, y: 10)
//// Physics body is just slightly above the baseline of the text
letterE.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 18, height: 25), center: CGPoint(x: 0, y: 10))
scene.addChild(letterE)

let letterE2 = SKLabelNode(fontNamed: "Rockwell")
letterE2.fontSize = 36
letterE2.fontColor = .white
letterE2.text = "e"
letterE2.position = CGPoint(x: 414, y: 10)
//// Physics body is just slightly above the baseline of the text
letterE2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 18, height: 25), center: CGPoint(x: 0, y: 10))
scene.addChild(letterE2)

let letterS = SKLabelNode(fontNamed: "Rockwell")
letterS.fontSize = 36
letterS.fontColor = .white
letterS.text = "s"
letterS.position = CGPoint(x: 414, y: 10)
//// Physics body is just slightly above the baseline of the text
letterS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 18, height: 25), center: CGPoint(x: 0, y: 10))
scene.addChild(letterS)

/*:

 [Previous: Adding Nodes Repeatedly](@previous) | Page 7 | [Next: Animating a Sprite](@next)
 
 
 */
