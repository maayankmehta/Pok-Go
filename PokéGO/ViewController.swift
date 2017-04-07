//
//  ViewController.swift
//  PokéGO
//
//  Created by Mayank Mehta on 06/04/17.
//  Copyright © 2017 Mayank Mehta. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var pokemon : [Pokemon] = []

    @IBOutlet weak var mapView: MKMapView!
    
    //reset the location tu current using button
    @IBAction func userLocationRepositioningButtonPress(_ sender: Any) {
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)
    }
    
    var manager = CLLocationManager()
    var update = 0
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager.delegate = self
        self.mapView.delegate = self
        
        // Authorization status and location settings
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            
            //shows current location blue point
            self.mapView.showsUserLocation = true
            
            self.manager.startUpdatingLocation()
            
            
            //from dbhelper
            pokemon = bringAllPokemon()
            
            //equation to find the annotation
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block:{ (timer) in
                
                if let coordinate = self.manager.location?.coordinate {
                    //get value for pokemon
                    let randomPokemon = Int(arc4random_uniform(UInt32(self.pokemon.count)))
                    let pokemon = self.pokemon[randomPokemon]
                    
                    
                    let annotation = PokemonAnnotation(coordinate: coordinate, pokemon: pokemon)
                    annotation.coordinate = coordinate
                    annotation.coordinate.latitude += (Double(arc4random_uniform(1000)) - 500) / 300000
                     annotation.coordinate.longitude += (Double(arc4random_uniform(1000)) - 500) / 300000
                    self.mapView.addAnnotation(annotation)
                    
                    
                }
            }
            )
            
        }else{
            self.manager.requestWhenInUseAuthorization()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation{
            annotationView.image = #imageLiteral(resourceName: "player")
        }else{
            let pokemon = (annotation as! PokemonAnnotation).pokemon
            annotationView.image = UIImage.init(named: pokemon.imageFileName!)
            }
        var newFrame = annotationView.frame
        newFrame.size.width = 40
        newFrame.size.height = 40
        annotationView.frame = newFrame
        
        return annotationView
    }
    
    
    
    
    //set region and update at the same position
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if update < 4 {
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)
            update += 1
        }else{
            self.manager.stopUpdatingLocation()
        }
            }
    
    
    //for selecting the pokemon's region
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: true)
        
        if view.annotation! is MKUserLocation {
            return
        }
        
        //zoom settings
        let region = MKCoordinateRegionMakeWithDistance((view.annotation?.coordinate)!, 150, 150)
        self.mapView.setRegion(region, animated: true)
        
        //setting range around the user in which it can click on annotation
        if let coordinate = self.manager.location?.coordinate {
            if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coordinate)){
                
                let battle = BattleViewController()
                
                //get a pokemon to send to battleviewcontroller
                let pokemon = (view.annotation as! PokemonAnnotation).pokemon
                battle.pokemon = pokemon
                
                //telling the viewcontroller to give the access to battleviecontroller(making segue to battlescen)
                self.present(battle, animated: true, completion: nil)
                
                print("in range")
            }else{
                print("out of range")
            }
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

