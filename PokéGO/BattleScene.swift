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
    
    override func didMove(to view: SKView) {
        //print("CatchEM")
        //print(pokemon.name)
        
        // Background Code
        let battleBg = SKSpriteNode(imageNamed: "bggg")
        battleBg.size = self.size
        battleBg.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        battleBg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        battleBg.zPosition = -1
        self.addChild(battleBg)
        
        //call pokemon and pokeball func
        self.perform(#selector(setupPokemon), with: nil, afterDelay: 2.0)
        self.perform(#selector(setupPokeball), with: nil, afterDelay: 2.0)
        
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
        
        self.addChild(pokemonSprite)
        
    }
    
    //Pokeball code
    func setupPokeball() {
        self.pokeballSprite = SKSpriteNode(imageNamed: "pokeball")
        self.pokeballSprite.size = kPokeballSize
        self.pokeballSprite.position = CGPoint(x: self.size.width/2, y: 100)
        self.pokeballSprite.zPosition = 1
        self.addChild(pokeballSprite)
        
        
    }
    
}
