//
//  ViewController.swift
//  PokéGO
//
//  Created by Mayank Mehta on 06/04/17.
//  Copyright © 2017 Mayank Mehta. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    //reset the location tu current using button
    @IBAction func userLocationRepositioningButtonPress(_ sender: Any) {
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)
    }
    
    var manager = CLLocationManager()
    var update = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager.delegate = self
        
        // Authorization status and location settings
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            
            //shows current location blue point
            self.mapView.showsUserLocation = true
            
            self.manager.startUpdatingLocation()
            
            //equation to find the annotation
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block:{ (timer) in
                
                if let coordinate = self.manager.location?.coordinate {
                    let annotation = MKPointAnnotation()
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

