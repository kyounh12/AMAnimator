//
//  MyCustomView.swift
//  WMAnimator_Example
//
//  Created by Moly on 2020/05/03.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import WMAnimator

class MyCustomView: UIView, WMAnimationView {
    
    private var testView: UIView!
    
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
        
        // Configure Your Custom View
        self.backgroundColor = .clear
        
        testView = UIView()
        testView.backgroundColor = .red
        
        addSubview(testView)
        
        (testView).translatesAutoresizingMaskIntoConstraints = false
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

