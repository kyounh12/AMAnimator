//
//  WMAnimationView.swift
//  Pods-WMAnimator_Example
//
//  Created by Moly on 2020/05/03.
//

import Foundation
import UIKit

public protocol WMAnimationView: UIView {
    
    /// Function to animate WMAnimationView. You should implement your own animation.
    func startAnimation()
    
    /// Function to stop WMAnimationView animation.
    func stopAnimation()
    
}
