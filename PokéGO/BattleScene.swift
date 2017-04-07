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
    
    override func didMove(to view: SKView) {
        print("CatchEM")
        
        print(pokemon.name)
    }
    
}
