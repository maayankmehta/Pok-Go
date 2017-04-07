//
//  CDHelper.swift
//  PokéGO
//
//  Created by Mayank Mehta on 06/04/17.
//  Copyright © 2017 Mayank Mehta. All rights reserved.
//

import CoreData
import UIKit

func makeAllPokemon(){
    
    makePokemon(name: "Abra", withThe: "abra")
    makePokemon(name: "Pikachu", withThe: "pikachu-2")
    makePokemon(name: "Psyduck", withThe: "psyduck")
    makePokemon(name: "Jigglypuff", withThe: "jigglypuff")
    makePokemon(name: "Bellsprout", withThe: "bellsprout")
    makePokemon(name: "Bullbasaur", withThe: "bullbasaur")
    makePokemon(name: "Charmander", withThe: "charmander")
    makePokemon(name: "Pidgey", withThe: "pidgey")
    makePokemon(name: "Mankey", withThe: "mankey")
    makePokemon(name: "Snorlax", withThe: "snorlax")
    makePokemon(name: "Charizard", withThe: "charizard")
    makePokemon(name: "Zubat", withThe: "zubat")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
}

func makePokemon(name: String, withThe imageName: String){
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageFileName = imageName
    
}

func bringAllPokemon() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons.count == 0 {
            makeAllPokemon()
            return bringAllPokemon()
        }else{
            return pokemons
        }
    }catch{
        print("Error")
        
    }
    
    return[]
}

func getAllCaughtPokemon() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "timesCaught > %d", 0)
    do{
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    }catch{
        print("error")
        
    }
    
    
    
    
    return []
}

func getAllUncaughtPokemon() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "timesCaught == %d", 0)
    do{
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    }catch{
        print("error")
        
    }
    
    
    return[]
}

