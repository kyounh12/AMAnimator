# WMAnimator

[![CI Status](https://img.shields.io/travis/Moly/WMAnimator.svg?style=flat)](https://travis-ci.org/Moly/WMAnimator)
[![Version](https://img.shields.io/cocoapods/v/WMAnimator.svg?style=flat)](https://cocoapods.org/pods/WMAnimator)
[![License](https://img.shields.io/cocoapods/l/WMAnimator.svg?style=flat)](https://cocoapods.org/pods/WMAnimator)
[![Platform](https://img.shields.io/cocoapods/p/WMAnimator.svg?style=flat)](https://cocoapods.org/pods/WMAnimator)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

With given locations of cities.
```swift
// Locations of some cities.
let locations: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 37.5171133, longitude: 126.9148678),  // Seoul
    CLLocationCoordinate2D(latitude: 51.5287718, longitude: -0.241681), // London
    CLLocationCoordinate2D(latitude: 38.8937091, longitude: -77.0846159),  // Washington
    CLLocationCoordinate2D(latitude: 35.5062909, longitude: 138.6486605),  // Tokyo
]
```

Configure your custom WMAnimationView with Lottie.
```swift
class MyLottieView: UIView, WMAnimationView {
}
```

Implement `startAnimation()` and `stopAnimation()` functions.
```swift
class MyLottieView: UIView, WMAnimationView {
    
    let circleView = AnimationView(name: "myLottie")
    
    ...
    
    private func initialize() {
        
        self.backgroundColor = .clear
        addSubview(circleView)
        
        // Configure constraints
        circleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: circleView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: circleView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: circleView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: circleView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    func startAnimation() {
        // Starts animation from start
        circleView.stop()
        circleView.play(fromProgress: 0, toProgress: 1)
        
    }
    
    func stopAnimation() {
        // Stops animation
        circleView.stop()
    }
    
}

```

Implement `WMWorldMapViewDelegate` to provide size for each `WMAnimationView`
```swift
extension ViewController: WMWorldMapViewDelegate {
    func sizeForAnimationView(worldMapView: WMWorldMapView, at index: Int) -> CGSize {
        return CGSize(
            width: 5,
            height: 5
        )
    }
}
```

Create `WMAnimatingLocation` array with your locations and `WMAnimationView`. And additionally set some properties to customize your WMWorldMapView.
```swift
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
```

Or you can also create WMAnimationView with your own animations
```swift
class MyCustomView: UIView, WMAnimationView {
    
    private var testView: UIView!
    
    ...
    
    private func initialize() {
        
        // Configure Your Custom View
        self.backgroundColor = .clear
        
        testView = UIView()
        testView.backgroundColor = .red
        
        addSubview(testView)
        
        testView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: testView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: testView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: testView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: testView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    func startAnimation() {
        self.testView.alpha = 0
        
        // Implement your custom animation here.
        UIView.animate(withDuration: 0.5, animations: {
            self.testView.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.5) {
                self.testView.alpha = 0
            }
        }
    }
    
    func stopAnimation() {
        // Implement your custom animation removal here.
        testView.layer.removeAllAnimations()
    }
}
```

Then again, create `WMAnimatingLocation` array with your locations and `WMAnimationView`. And also set some properties to customize your WMWorldMapView.
```swift
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
```

<img src="https://imgur.com/vAKVnU3.gif" width="200" height="440" />


## Requirements

## Installation

WMAnimator is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WMAnimator'
```

## Author

Moly, kyounh12@snu.ac.kr

## License

WMAnimator is available under the MIT license. See the LICENSE file for more info.
