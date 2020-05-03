//
//  WMWorldMapView.swift
//  Pods-WMAnimator_Example
//
//  Created by Moly on 2020/05/03.
//

import Foundation
import UIKit
import CoreLocation

public enum ProjectionMethod {
    case gallStereographic
}

struct ProjectionBound {
    var minLat: CGFloat
    var maxLat: CGFloat
    var minLong: CGFloat
    var maxLong: CGFloat
}

public class WMWorldMapView: UIView {
    
    // MARK: - public variables
    
    /// WMWorldMapViewDelegate.
    public var delegate: WMWorldMapViewDelegate?
    
    /// Worldmap image. It changes image of `worldMapImageView`.
    public var worldMapImage: UIImage? = UIImage(named: "worldmap_gall_stereographic") {
        didSet {
            worldMapImageView.image = worldMapImage
        }
    }
    
    /// Worldmap image color. It changes tintColor of `worldMapImageView`.
    public var worldMapColor: UIColor = .black {
        didSet {
            worldMapImageView.tintColor = worldMapColor
        }
    }
    
    /// Animation Interval between WMAnimatingLocations in millisecond. Providing 300 means every WMAnimatingLocation starts animating 300ms after previous WMAnimatingLocation starts animating. Default value is 300
    public var animationInterval: Int = 300
    
    /// Animation repeat interval of each WMAnimatingLocations in millisecond. Providing 1000 means every WMAnimatingLocation repeats animation every 1000ms.
    public var animationRepeatInterval: Int = 1000
    
    /// Latitude offset of given worldMapImage. It is needed to calculate y coordinate on map from location. Default value is 0.
    public var latitudeOffset: CGFloat = 0
    
    /// Longitude offset of given worldMapImage. It is needed to calculate x coordinate on map from location. Default value is 0.
    public var longitudeOffset: CGFloat = 0
    
    // MARK: - private variables
    
    /// WMAnimationLocation array.
    private var locations: [WMAnimatingLocation] = []
    
    /// ImageView to show worldmap image.
    private var worldMapImageView: UIImageView = UIImageView()
    
    /// UIView to put animating views on.
    private var worldMapAnimationBackgroundView: UIView = UIView()
    
    /// DispatchSourceTimer array to save timers used to repeat animations of WMAnimationViews.
    private var timers: [DispatchSourceTimer] = []
    
    /// Projection method of map. It affects coordinate calculation.
    private var projectionMethod: ProjectionMethod = .gallStereographic
    
    /// Map projection bound. Latitude bound set to -+85 degree since mercator projection cannot represent latitude on -+90 degree.
    private var projectionBound: ProjectionBound = ProjectionBound(minLat: -85, maxLat: 85, minLong: -180, maxLong: 180)
    
    // MARK: - initialization functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    /// Common Initializer for WMWorldMapView.
    private func initialize() {
        // Add worldMapImageView and worldMapAnimationBackgroundView
        addSubview(worldMapImageView)
        addSubview(worldMapAnimationBackgroundView)
        
        // ImageView's contentMode is set to scaleAspectFill to proper calculation.
        worldMapImageView.contentMode = .scaleAspectFill
        
        // ImageView's properties
        worldMapImageView.tintColor = worldMapColor
        worldMapImageView.image = worldMapImage
        
        // Sets worldMapImageView constraints. Height is determined by projection method and projection bound.
        worldMapImageView.alignLeading(to: self)
        worldMapImageView.alignTrailing(to: self)
        worldMapImageView.alignCenterY(to: self)
        worldMapImageView.setAspectRatio(multiplier: calculateProjectionWidthHeightRatio())
        
        // worldMapAnimationBackgroundView properties
        worldMapAnimationBackgroundView.backgroundColor = .clear
        
        // Sets worldMapAnimationBackgroundView constraints. Follows size of worldMapImageView
        worldMapAnimationBackgroundView.scaleToFill(to: worldMapImageView)
    }
    
    // MARK: - public functions
    
    /// Sets `locations` of WMWorldMapView and adds all WMAnimationView of WMAnimatingLocations to `worldMapanimationBackgroundView`.
    /// - Parameter locations: WMAnimatingLocations array.
    public func setLocations(locations: [WMAnimatingLocation]) {
        
        // Remove all subviews of worldMapAnimationBackgroundView.
        for subview in worldMapAnimationBackgroundView.subviews {
            subview.removeFromSuperview()
        }
        
        // Sets locations of WMWorldMapView
        self.locations = locations
        
        // Loop through locations array and add subviews
        for i in 0..<self.locations.count {
            
            // WMAnimatingLocation instance.
            let location = self.locations[i]
            
            // Hide WMAnimationView and remove it from superview.
            location.animationView.isHidden = true
            location.animationView.removeFromSuperview()
            
            // Add WMAnimationView to worldMapAnimationBackgroundView.
            worldMapAnimationBackgroundView.addSubview(location.animationView)
            
            // Gets WMAnimationView Size and center constraints.
            let viewSize = getSizeForAnimationView(at: i)
            let centerXY = calculateCenterOnMap(location: location.location)
            
            // Sets WMAnimationView constraints.
            location.animationView.setWidth(constant: viewSize.width)
            location.animationView.setHeight(constant: viewSize.height)
            location.animationView.alignCenterX(to: worldMapAnimationBackgroundView, constant: 0, multiplier: centerXY.x)
            location.animationView.alignCenterY(to: worldMapAnimationBackgroundView, constant: 0, multiplier: centerXY.y)
        }
    }
    
    /// Starts animations of WMAnimationViews. It fires `startAnimation()` of each WMAnimationView and show WMAnimation view. Each animation repeats every `animationRepeatInterval` milliseconds and every WMAnimationView starts animate `animationInterval` millisecond after previous WMAnimationView starts animate.
    public func startAnimation() {
        
        // Stop animation first.
        stopAnimation()
        
        // Loop through WMAnimationLocation and start animations
        for i in 0..<locations.count {
            
            // WMAnimationLocation instance.
            let location = locations[i]
            
            // Show WMAnimationView
            location.animationView.isHidden = false
            
            // Set timer to loop animations.
            let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            timer.schedule(deadline: .now() + .milliseconds(animationInterval * i), repeating: .milliseconds(animationRepeatInterval))
            timer.setEventHandler{
                location.animationView.startAnimation()
            }
            timer.resume()
            
            // Appends timer to timers array.
            timers.append(timer)
        }
    }
    
    
    /// Stops animations of WMAnimationViews. It fires `stopAnimation()` of each WMAnimationView and hide WMAnimation view.
    public func stopAnimation() {
        
        // Stops all animation timers
        for timer in timers {
            timer.cancel()
        }
        
        // Stops all WMAnimationView animations and hide views.
        for location in locations {
            location.animationView.stopAnimation()
            location.animationView.isHidden = true
        }
        
        // Removes all animation timers
        timers = []
    }
    
    // MARK: - private functions
    
    /// Calculates height/width ratio of current projection method with it's bound.
    /// - Returns: height/width ratio of current projection method.
    private func calculateProjectionWidthHeightRatio() -> CGFloat {
        
        if projectionMethod == .gallStereographic {
            // Calculate max/min coordinates of current boundary.
            let max = calculateXYfromCoordinate(radius: 1, location: CLLocationCoordinate2D(latitude: CLLocationDegrees(projectionBound.maxLat), longitude: CLLocationDegrees(projectionBound.maxLong)))
            let min = calculateXYfromCoordinate(radius: 1, location: CLLocationCoordinate2D(latitude: CLLocationDegrees(projectionBound.minLat), longitude: CLLocationDegrees(projectionBound.minLong)))

            // Calculate height/width ratio from max/min coordinates
            return abs(max.y - min.y)/abs(max.x - min.x)
            
        }
        
        return 1
    }
    
    /// Calculates x,y coordinate from given lat/lng without offset.
    /// - Parameters:
    ///   - radius: Radius of sphere.
    ///   - latitude: Latitude of location.
    ///   - longitude: Longitude of location.
    /// - Returns: CGPoint with x,y coordinate.
    private func calculateXYfromCoordinate(radius: CGFloat, location: CLLocationCoordinate2D) -> CGPoint {
        
        if projectionMethod == .gallStereographic {
            
            // Calculate lat/lng radian from degrees
           let lng = CGFloat(location.longitude)
           let lat = CGFloat(location.latitude)
           
           let lngRad = lng * CGFloat.pi / 180
           let latRad = lat * CGFloat.pi / 180
    
            // Calculate x,y coordinate value with gall stereographic prjection.
            let x = lngRad * radius / sqrt(2)
            let y = radius * (1 + sqrt(2)/2) * tan(latRad/2)
            
            return CGPoint(x: x, y: y)
        }
        
        return CGPoint(x: -1, y: -1)
    }
    
    /// Calculates centerX,Y constraint multiplier value from given location with offset.
    /// - Parameter location: Location to calculate centerXY.
    /// - Returns: CGPoint with centerX,Y value.
    private func calculateCenterOnMap(location: CLLocationCoordinate2D) -> CGPoint {
        
        if projectionMethod == .gallStereographic {
            // Calculate Lat/Lng in Radian with offset
            let latLng = calculateRadianWithOffset(location: location)
            
            // Height/Width ratio
            let widthHeightRatio = calculateProjectionWidthHeightRatio()
            
            // Center ratio in range(0,1), 0.5 indicates center
            var centerX = latLng.x / (2 * CGFloat.pi) + 0.5
            var centerY = 0.5 - (sqrt(2) + 1) / (2 * CGFloat.pi * widthHeightRatio) * tan(latLng.y/2)
            
            // Calculate constraint center value, 0 means leftmost, 1 means center and 2 means rightmost.
            centerX = max(min(centerX * 2, 2), 0.00001)
            centerY = max(min(centerY * 2, 2), 0.00001)
            
            return CGPoint(x: centerX, y: centerY)
        }
        
        return CGPoint(x: 0.00001, y: 0.00001)
    }
    
    /// Calculates radian lat/lng from given location with location offset.
    /// - Parameter location: Location to calculate radian lat/lng.
    /// - Returns: CGPoint with lat/lng in radian.
    private func calculateRadianWithOffset(location: CLLocationCoordinate2D) -> CGPoint {
        // Calculate Lat/Lng in Radian with offset
        let lng = CGFloat(location.longitude) + longitudeOffset
        let lat = CGFloat(location.latitude) + latitudeOffset
        
        var lngRad = lng * CGFloat.pi / 180
        var latRad = lat * CGFloat.pi / 180
        
        // Calculate Lat/Lng to fit in its range (lng=-pi~pi, lat=-pi/2~pi/2)
        if lng > 180 || lng < -180 {
            lngRad = (lngRad + CGFloat.pi).truncatingRemainder(dividingBy: CGFloat.pi * 2) - CGFloat.pi
        }
        
        if lat > 90 || lat < -90 {
            latRad = (latRad + CGFloat.pi / 2).truncatingRemainder(dividingBy: CGFloat.pi) - CGFloat.pi / 2
        }
        
        return CGPoint(x: lngRad, y: latRad)
    }
    
    /// Gets size of animation view at given index from delegate.
    /// - Parameter index: Index of animation view to get size.
    /// - Returns: CGSize of animation view.
    private func getSizeForAnimationView(at index: Int) -> CGSize {
        return delegate?.sizeForAnimationView(worldMapView: self, at: index) ?? CGSize(width: 4, height: 4)
    }
}

public protocol WMWorldMapViewDelegate: class {
    /// Should provide size of each WMAnimationView.
    /// - Parameters:
    ///   - worldMapView: WMWorldMapView instance.
    ///   - index: Index of WMAnimationView in `locations` array.
    func sizeForAnimationView(worldMapView: WMWorldMapView, at index: Int) -> CGSize
}

