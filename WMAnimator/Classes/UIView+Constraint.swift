//
//  UIView+Constraint.swift
//  Pods-WMAnimator_Example
//
//  Created by Moly on 2020/05/03.
//

import Foundation
import UIKit

extension UIView {
    
    @discardableResult
    func alignLeading(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .leading,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignTrailing(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .trailing,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignTop(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .top,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignBottom(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .bottom,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignCenterX(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .centerX,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignCenterY(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .centerY,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }

    func alignCenter(to view: UIView?) {
        alignCenterX(to: view, constant: 0, multiplier: 1)
        alignCenterY(to: view, constant: 0, multiplier: 1)
    }
    
    @discardableResult
    func setAspectRatio(multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .width,
                                            multiplier: multiplier,
                                            constant: 0)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func setHeight(constant: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .height,
                                            multiplier: 1,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func setWidth(constant: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func setEqualWidth(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
       return setWidth(to: view, relation: .equal, constant: constant, multiplier: multiplier)
    }
    
    @discardableResult
    func setEqualHeight(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
       return setHeight(to: view, relation: .equal, constant: constant, multiplier: multiplier)
    }
    
    @discardableResult
    func setWidth(to view: UIView?,
                  relation: NSLayoutConstraint.Relation = .equal,
                  constant: CGFloat = 0,
                  multiplier: CGFloat = 1,
                  priority: Float = 1000,
                  attribute: NSLayoutConstraint.Attribute = .width) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: relation,
                                            toItem: view,
                                            attribute: attribute,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func setHeight(to view: UIView?,
                   relation: NSLayoutConstraint.Relation = .equal,
                   constant: CGFloat = 0,
                   multiplier: CGFloat = 1,
                   priority: Float = 1000,
                   attribute: NSLayoutConstraint.Attribute = .height) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: relation,
                                            toItem: view,
                                            attribute: attribute,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignWestSide(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .trailing,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignEastSide(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .leading,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignNorthSide(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .bottom,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func alignSouthSide(to view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .top,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        
        return constraint
    }
    
    func scaleToFill(to view: UIView) {
        alignLeading(to: view)
        alignTrailing(to: view)
        alignTop(to: view)
        alignBottom(to: view)
    }
}

