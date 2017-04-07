//
//  BattleScene.swift
//  PokéGO
//
//  Created by Mayank Mehta on 07/04/17.
//  Copyright © 2017 Mayank Mehta. All rights reserved.
//

import UIKit
import SpriteKit

class BattleScene : SKScene, SKPhysicsContactDelegate {
    
    var pokemon : Pokemon!
    
    //creating spirtes
    var pokemonSprite : SKSpriteNode!
    var pokeballSprite : SKSpriteNode!
    
    //define constants
    let kPokemonSize = CGSize(width: 140, height: 140)
    let kPokeballSize = CGSize(width: 60, height: 60)
    
    
    //define bitcategories
    let kPokeballCategory : UInt32 = 0x1 << 0
    let kPokemonCategory : UInt32 = 0x1 << 1
    let kEdgeCategory : UInt32 = 0x1 << 2
    
    
    //physics variable setup
    var velocity : CGPoint = CGPoint.zero
    var touchPoint : CGPoint = CGPoint()
    var canThrowPokeball : Bool = false
    
    //
    
    
    override func didMove(to view: SKView) {
        //print("CatchEM")
        //print(pokemon.name)
        
        // Background Code
        let battleBg = SKSpriteNode(imageNamed: "bggg")
        battleBg.size = self.size
        battleBg.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        battleBg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        battleBg.zPosition = -1
        
        //call pokemon and pokeball func
        self.perform(#selector(setupPokemon), with: nil, afterDelay: 2.0)
        self.perform(#selector(setupPokeball), with: nil, afterDelay: 2.0)
        
        
        //setup physics
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = kEdgeCategory
        
        self.physicsWorld.contactDelegate = self
        
        self.addChild(battleBg)
    }
    
    //Pokemon code
    func setupPokemon() {
        self.pokemonSprite = SKSpriteNode(imageNamed: pokemon.imageFileName!)
        self.pokemonSprite.size = kPokemonSize
        self.pokemonSprite.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.pokemonSprite.zPosition = 1
        
        //movements
        let moveRight = SKAction.moveBy(x: 100, y: 0, duration: 3.0)
        let sequence = SKAction.sequence([moveRight, moveRight.reversed(), moveRight.reversed(), moveRight])
        //keep the pokemon moving forever
        self.pokemonSprite.run(SKAction.repeatForever(sequence))
        
        //setup pokemon physics
        self.pokemonSprite.physicsBody = SKPhysicsBody(rectangleOf: kPokemonSize)
        self.pokemonSprite.physicsBody?.isDynamic = false
        self.pokemonSprite.physicsBody?.affectedByGravity = false
        self.pokemonSprite.physicsBody?.mass = 5.0
        
        //bitmask
        self.pokemonSprite.physicsBody?.categoryBitMask = kPokemonCategory
        self.pokemonSprite.physicsBody?.collisionBitMask = kEdgeCategory
        self.pokemonSprite.physicsBody?.contactTestBitMask = kPokeballCategory
        
        self.addChild(pokemonSprite)
    }
    
    //Pokeball code
    func setupPokeball() {
        self.pokeballSprite = SKSpriteNode(imageNamed: "pokeball")
        self.pokeballSprite.size = kPokeballSize
        self.pokeballSprite.position = CGPoint(x: self.size.width/2, y: 100)
        self.pokeballSprite.zPosition = 1
        
        // setup pokeball physics
        self.pokeballSprite.physicsBody = SKPhysicsBody(circleOfRadius: self.pokeballSprite.frame.size.width/2)
        self.pokeballSprite.physicsBody?.affectedByGravity = true
        self.pokeballSprite.physicsBody?.isDynamic = true
        self.pokeballSprite.physicsBody?.mass = 0.5
        
        //bitmask
        self.pokeballSprite.physicsBody?.categoryBitMask = kPokeballCategory
        self.pokeballSprite.physicsBody?.collisionBitMask = kPokemonCategory | kEdgeCategory
        self.pokeballSprite.physicsBody?.contactTestBitMask = kPokemonCategory
        
        self.addChild(pokeballSprite)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        
        if self.pokeballSprite.frame.contains(location!){
            self.canThrowPokeball = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            let touch = touches.first
            let location = touch?.location(in: self)
            self.touchPoint = location!
            if self.canThrowPokeball == true {
                throwPokeball()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch  contactMask {
        case kPokemonCategory | kPokeballCategory :
            print("pokemon has been caught")
            
        default:
            <#code#>
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        <#code#>
    }
    
    func throwPokeball() {
        self.canThrowPokeball = false
        let dt : CGFloat = 1.0/50
        
        let distance = CGVector(dx: self.touchPoint.x - self.pokeballSprite.position.x, dy: self.touchPoint.y - self.pokeballSprite.position.y)
        let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
        self.pokeballSprite.physicsBody?.velocity = velocity
        
        
    }
    
    func endgame() {
        
    }
    
    func endbattle() {
        
    }
    
}
