//
//  GameScene.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 14/12/23.
//

import SpriteKit
import GameplayKit


struct PhysicsCategory{
    static let none     :UInt32 = 0
    static let all      :UInt32 = UInt32.max
    static let player   :UInt32 = 0b1
    static let platform :UInt32 = 0b10
}

class GameScene: SKScene {
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    var gameLogic: GameLogic = GameLogic.shared
    
    // Keeps track of when the last update happend.
    // Used to calculate how much time has passed between updates.
    var lastUpdate: TimeInterval = 0
    
    var player: SKSpriteNode!
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    var playerAnimation = [SKTexture]()
    
    //difficoltà gioco
   
    var platformCreationInterval: Double = 5.0 // Intervallo iniziale tra la creazione di piattaforme
    var difficultyIncreaseRate: Double = 0.5 // Velocità di aumento della difficoltà

    let defaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
        
        if defaults.value(forKey: "highscore") == nil {
            defaults.setValue(0, forKey: "highscore")
        }
    }
    
    
    func moveBackGrounds(image: String,x:CGFloat,z:CGFloat, duration:Double, needPhysics: Bool, size:CGSize){
        for i in 0...1{
            
            let node = SKSpriteNode(imageNamed:image)
            
            node.anchorPoint = .zero
            node.position = CGPoint(x: x, y: -size.height * CGFloat(i))
            node.size = size
            node.zPosition = z
            
            if needPhysics {
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody?.isDynamic = false
                node.physicsBody?.contactTestBitMask = 1
                node.name = "enemy"
            }
            
            let move = SKAction.moveBy(x: 0, y: node.size.height, duration: duration)
            let wrap = SKAction.moveBy(x: 0, y: -node.size.height, duration: 0)
            let sequence = SKAction.sequence([move,wrap])
            let ripetizione = SKAction.repeatForever(sequence)
            
            node.run(ripetizione)
            
            addChild(node)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // ...
        if isMovingToTheRight{
            self.moveRight()
        }
        
        if isMovingToTheLeft{
            self.moveLeft()
        }
        // Check if the player is beyond the upper limit of the screen
        if let player = self.player, player.position.y > self.frame.maxY {
            // Player is beyond the upper limit, perform the action you want (e.g., end the game)
            self.playerOutOfBounds()
        }
        // If the game over condition is met, the game will finish
        if self.isGameOver { self.finishGame() }
        
        
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        // Increments the length of the game session at the game logic
        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        
        self.lastUpdate = currentTime
    }
    
    private func playerOutOfBounds() {
        // Handle what happens when the player goes beyond the upper limit
        print("Player out of bounds! Game Over.")
        self.finishGame() // You can call your existing finishGame method or perform any other actions.
    }
    
}


// MARK: - Game Scene Set Up
extension GameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        
        
        //backgrounds
        moveBackGrounds(image: "backgroundCavern", x:  0, z: -5, duration: 14, needPhysics: false, size: self.size)
        moveBackGrounds(image: "background2", x:  0, z: -4, duration: 12, needPhysics: false, size: self.size)
        moveBackGrounds(image: "background3", x:  0, z: -3, duration: 8, needPhysics: false, size: self.size)
        
        
        let playerInitialPosition = CGPoint(x: self.frame.width/2, y: 200 + self.frame.height/2)
        self.createPlayer(at: playerInitialPosition)
        
        self.startPlatformsCycle()
        
        
    }
    
    private func setUpPhysicsWorld() {
        // TODO: Customize!
        physicsWorld.gravity = CGVector(dx: 0, dy: 0.9) //il vettore (gravità) va verso il basso, ovvero sta cadendo
        //andiamo ora a definire un corpo andando a createPlayer e aggiungiamo le righe 85-86
        physicsWorld.contactDelegate = self
        
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func createPlayer(at position: CGPoint) {
        
        self.player = SKSpriteNode(imageNamed: "dive1")
        self.player.name = "player"
        self.player.position = position
        self.player.setScale(1.7)
        self.player.zPosition = 5
        
        
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        player.physicsBody?.affectedByGravity = false
        //ora andiamo anche dagli platform e aggiungiamo le righe 213-214
        
        player.physicsBody?.categoryBitMask = PhysicsCategory.player //con quest il codice capisce che il player è il player
        
        player.physicsBody?.contactTestBitMask = PhysicsCategory.platform
        player.physicsBody?.collisionBitMask = PhysicsCategory.platform
        
        let xRange = SKRange(lowerLimit: 0, upperLimit: frame.width) //evitiamo che la palla esca dallo schermo
        let xConstraint = SKConstraint.positionX(xRange)
        self.player.constraints = [xConstraint]
        
        addChild(self.player)
        
        //animation
        let textureAtlas = SKTextureAtlas (named:"dive")
        
        for i in 1...textureAtlas.textureNames.count{
            let name = "dive" + String(i)
            playerAnimation.append(textureAtlas.textureNamed(name))
        }
        
        player.run(SKAction.repeatForever(SKAction.animate (with: playerAnimation, timePerFrame:0.10)))
        
    }
    
    func startPlatformsCycle() {
        let createPlatformAction = SKAction.run {
            self.createPlatform()
        }
        
        
        
        // Velocità della creazione delle piattaforme
        let waitAction = SKAction.wait(forDuration: platformCreationInterval)
        let createAndWaitAction = SKAction.sequence([createPlatformAction, waitAction])

        let platformCycleAction = SKAction.repeatForever(createAndWaitAction)
        run(platformCycleAction)

        // Programma la diminuzione dell'intervallo tra la creazione di piattaforme nel tempo
        let decreaseIntervalAction = SKAction.run {
            if self.gameLogic.sessionDuration < 30 {
                self.platformCreationInterval = max(self.platformCreationInterval - self.difficultyIncreaseRate, 1.0)
            }
        }

        
        if self.gameLogic.sessionDuration < 30 {
            let delayAction = SKAction.wait(forDuration: 10.0) // Riduci l'intervallo ogni secondo
            let decreaseIntervalSequence = SKAction.sequence([delayAction, decreaseIntervalAction])

            // Cambiato da repeatForever a run per eseguire l'azione una sola volta
            run(decreaseIntervalSequence) {
                // Dopo l'esecuzione, richiama nuovamente startPlatformsCycle
                self.startPlatformsCycle()
            }
        }

    }


}


// MARK: - Player Movement
extension GameScene {
    
}

// MARK: - Handle Player Inputs
extension GameScene {
    
    enum SideOfTheScreen {
        case right, left
    }
    
    private func sideTouched(for position: CGPoint) -> SideOfTheScreen {
        if position.x < self.frame.width / 2 {
            return .right
        } else {
            return .left
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        switch sideTouched(for: touchLocation) {
        case .right:
            self.isMovingToTheRight = true
            player.xScale = (1.7)
            
        case .left:
            self.isMovingToTheLeft = true
            player.xScale = (-1.7)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMovingToTheRight = false
        self.isMovingToTheLeft = false
    }
    
}


// MARK: - Game Over Condition
extension GameScene {
    
    /**
     * Implement the Game Over condition.
     * Remember that an arcade game always ends! How will the player eventually lose?
     *
     * Some examples of game over conditions are:
     * - The time is over!
     * - The player health is depleated!
     * - The enemies have completed their goal!
     * - The screen is full!
     **/
    
    var isGameOver: Bool {
        // TODO: Customize!
      
        // Did you reach the time limit?
        // Are the health points depleted?
        // Did an enemy cross a position it should not have crossed?
        
        return gameLogic.isGameOver
    }
    
    private func finishGame() {
        
        // TODO: Customize!
    
        gameLogic.isGameOver = true
        
    }
    
}

// MARK: - Register Score
extension GameScene {
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}

// MARK: - platforms
extension GameScene {
    
    
        
    
    private func createPlatform() {
            let platformPosition = self.randomPlatformPosition()
            newPlatform(at: platformPosition)
            
        }
        
    
    private func randomPlatformPosition() -> CGPoint {
        let initialX: CGFloat = 25
        let finalX: CGFloat = self.frame.width - 25
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY =  25
        
        return CGPoint(x: positionX, y: CGFloat(positionY))
    }
    
    private func newPlatform(at position: CGPoint) {
        let platformTexture = SKTexture(imageNamed: "platformexp1") // Sostituisci "Platform" con il nome reale dell'immagine
        let newPlatform = SKSpriteNode(texture: platformTexture)
        newPlatform.name = "platform"
       
        newPlatform.position = position
        
        newPlatform.physicsBody = SKPhysicsBody(rectangleOf: newPlatform.size)
        newPlatform.physicsBody?.affectedByGravity = true
        
        newPlatform.physicsBody?.categoryBitMask = PhysicsCategory.platform //con quest il codice capisce che il platform è platform, identificazione del body
        
        newPlatform.physicsBody?.contactTestBitMask = PhysicsCategory.player //cosa può toccare, affinché succeda qualcosa
        newPlatform.physicsBody?.collisionBitMask = PhysicsCategory.player //quando due corpi si scontrano, ci sono delle collisioni, ad es. mario quando non salta e tocca il gradino, rimane bloccato
        
        addChild(newPlatform)
        
        newPlatform.run(SKAction.sequence([
            SKAction.wait(forDuration: 5.0),
            SKAction.removeFromParent()
        ]))
    }
    
    
}

// MARK: - Player Movement
extension GameScene {
    
    private func moveLeft(){
        self.player.physicsBody?
            .applyForce(CGVector(dx: 30, dy: 0))
        
        print("Moving Left: \(player.physicsBody!.velocity)")
        
    }
    
    private func moveRight(){
        self.player.physicsBody?
            .applyForce(CGVector(dx: -30, dy: 0))
        
        print("Moving Right: \(player.physicsBody!.velocity)")
    }
}





// MARK: - Contacts and Collisions
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact Happened!")
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if let node = firstBody.node, node.name == "platform" {
            node.removeFromParent() //remove the platform from the game
        }
        if let node = secondBody.node, node.name == "platform" {
            node.removeFromParent()
        }
    }
}

