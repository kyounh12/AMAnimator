//
//  WMAnimationLocation.swift
//  Pods-WMAnimator_Example
//
//  Created by Moly on 2020/05/03.
//

import Foundation
import UIKit
import CoreLocation

public struct WMAnimatingLocation {
    
    /// Location of WMAnimationView in degrees.
    public var location: CLLocationCoordinate2D!
    
    /// WMAnimationView instance.
    public var animationView: WMAnimationView!
    
    public init(location: CLLocationCoordinate2D, animationView: WMAnimationView) {
        self.location = location
        self.animationView = animationView
    }
    
}

