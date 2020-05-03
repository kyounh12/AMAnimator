//
//  ViewController.swift
//  WMAnimator
//
//  Created by Moly on 05/03/2020.
//  Copyright (c) 2020 Moly. All rights reserved.
//

import UIKit
import WMAnimator
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var worldMapView: WMWorldMapView!
    @IBOutlet weak var worldMapView2: WMWorldMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Locations of some cities.
        let locations: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 37.5171133, longitude: 126.9148678),  // Seoul
            CLLocationCoordinate2D(latitude: 51.5287718, longitude: -0.241681), // London
            CLLocationCoordinate2D(latitude: 38.8937091, longitude: -77.0846159),  // Washington
            CLLocationCoordinate2D(latitude: 35.5062909, longitude: 138.6486605),  // Tokyo
        ]
        
        // ======= Example 1 - worldMapView =======
        
        // Set delegate
        worldMapView.delegate = self
        
        // Set backgroundColor
        worldMapView.backgroundColor = .gray
        
        // Map locations to WMAnimatingLocation with Lottie Animation Views
        let wmLocations: [WMAnimatingLocation] = locations.map { (location) -> WMAnimatingLocation in
            return WMAnimatingLocation(location: location, animationView: MyLottieView())
        }
        
        // Set animation intervals
        worldMapView.animationRepeatInterval = 4000
        worldMapView.animationInterval = 1000
        
        // Set WMAnimatingLocations
        worldMapView.setLocations(locations: wmLocations)
        
        // Start Animation
        worldMapView.startAnimation()
        
        
        // ======= Example 2 - worldMapView2 =======
        
        // Set delegate
        worldMapView2.delegate = self
        
        // Set backgroundColor
        worldMapView2.backgroundColor = .clear
        
        // Map locations to WMAnimatingLocation with Custom Views
        let wmLocations2: [WMAnimatingLocation] = locations.map { (location) -> WMAnimatingLocation in
            return WMAnimatingLocation(location: location, animationView: MyCustomView())
        }
        
        // Set animation intervals
        worldMapView2.animationRepeatInterval = 2000
        worldMapView2.animationInterval = 800
        
        // Set worldMapImageView tintColor
        worldMapView2.worldMapColor = .white
        
        // Set worldMapImageView Image
        worldMapView2.worldMapImage = UIImage(named: "worldmap_gall_stereographic_180")
        
        // Set longitude offset
        worldMapView2.longitudeOffset = 180
        
        // Set WMAnimatingLocations
        worldMapView2.setLocations(locations: wmLocations2)
        
        // Start Animation
        worldMapView2.startAnimation()
        
    }
}

extension ViewController: WMWorldMapViewDelegate {
    func sizeForAnimationView(worldMapView: WMWorldMapView, at index: Int) -> CGSize {
        return CGSize(
            width: (8 - index) * (worldMapView == self.worldMapView ? 5 : 2),
            height: (8 - index) * (worldMapView == self.worldMapView ? 10 : 2)
        )
    }
}
