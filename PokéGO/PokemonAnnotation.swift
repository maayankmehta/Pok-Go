//
//  PokemonAnnotation.swift
//  PokéGO
//
//  Created by Mayank Mehta on 06/04/17.
//  Copyright © 2017 Mayank Mehta. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotation: NSObject,MKAnnotation{
    
    var coordinate = CLLocationCoordinate2D()
    var pokemon : Pokemon
    
    init(coordinate : CLLocationCoordinate2D,pokemon : Pokemon) {
        self.coordinate = coordinate
        self.pokemon = pokemon
    }
}
