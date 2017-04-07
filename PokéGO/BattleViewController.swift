//
//  BattleViewController.swift
//  PokéGO
//
//  Created by Mayank Mehta on 07/04/17.
//  Copyright © 2017 Mayank Mehta. All rights reserved.
//

import UIKit
import  SpriteKit

class BattleViewController: UIViewController {
    
    var pokemon : Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initializing scene
        let scene = BattleScene(size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        //changing from normal view to skview
        self.view = SKView()
        
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        
        //getting the pokemon from viewcontroller
        scene.pokemon = pokemon
        scene.scaleMode = .aspectFill
        
        
        //loading the made scene
        skView.presentScene(scene)
        
        NotificationCenter.default.addObserver(self, selector: #selector(returnToMapViewController), name: NSNotification.Name("CloseBattle"), object: nil)
        

        // Do any additional setup after loading the view.
    }
    
    func returnToMapViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
