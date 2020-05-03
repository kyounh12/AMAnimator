//
//  MyLottieView.swift
//  WMAnimator_Example
//
//  Created by Moly on 2020/05/03.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import WMAnimator
import Lottie

class MyLottieView: UIView, WMAnimationView {
    
    let circleView = AnimationView(name: "myLottie")
    
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

