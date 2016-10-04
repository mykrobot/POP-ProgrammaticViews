//
//  Constrainable.swift
//  POProgrammaticViews
//
//  Created by Michael Mecham on 9/20/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

/**
 The percentage used with the multiplier parameter of an NSLayoutConstraint to show the ration of the constraint between two views
*/

public enum ConstraintPercentage: Float {
    case Equal = 1.0
    case Half = 0.5
    case OneThird = 0.33
    case TwoThirds = 0.66
    case OneFourth = 0.25
    case ThreeFourths = 0.75
    case OneFifth = 0.2
    case TwoFifths = 0.4
    case ThreeFifths = 0.6
    case FourFifths = 0.8
}

/** 
 Allows conforming views to be laid out programmatically in an easy, clean, and readable fashion.
 The two styles used for adding a view are split into two groups: Alignments and Constraints.
 
 **Alignment vs Constraint**
 - Alignment: 
    Affects the **same** NSLayoutAttributes on both views where the attribute is an edge (ex: .Leading to .Leading).
 - Constraint:
    Affects **different** NSLayoutAttributes on both views (ex: .Leading to .Trailing) **or** Setting the .Width or .Height attributes of two objects with a multiplier.
*/

public protocol Constrainable {}

extension Constrainable where Self: UIView {
    
    // MARK: - Alignments
    
    /**
     Adds self to the super view and turns off auto resizing masks.
     - Parameters:
        - view: takes in the UIView that self will be added to as a subview.
     */
    
    func addTo(view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    /**
     Aligns the specified attribute between self and different view.
     - Parameters:
        - attribute: specify the NSLayoutAttribute which you would like to align
        - view: the view to which you will align self
     */
    
    func align(attribute: NSLayoutAttribute, toView view: UIView) {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint)
    }
    
    /**
     Aligns evenly all edges to the view.
     - Parameters:
        - view: the view to which you will be aligning all edges
     */
    
    func alignAllEdgesTo(view: UIView) {
        let attributes: [NSLayoutAttribute] = [.Top, .Leading, .Trailing, .Bottom]
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    /**
     Aligns a specific attribute to the specified view with an offset.
     - Parameters:
        - attribute: the desired NSLayoutAttribute that you would like to align
        - view: the view with the desired position and attribute that you would like to align with
        - offset: the amount of points by which to seperate the alignment
     */
    
    func align(attribute: NSLayoutAttribute, toView view: UIView, withOffset offset: CGFloat) {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: offset)
        view.addConstraint(constraint)
    }
    
    /**
     Aligns multiple attributes between two views with a specified offset.
     Must have same number of attributes and offsets.
     - Parameters:
        - attributes: an array of the desired NSLayoutAttributes that you would like to align
        - view: the view with the desired position and attribute that you would like to align with
        - offsets: an array containg the values by which to seperate each attribute between the two views. Each value corresponds to the index of the attribute
            - ex: attributes: [.Leading, .Top], offsets: [20, 64]
             The .Leading attribute will have an offset of 20 points while the .Top attribute will have an offset of 64 points.
     */
    
    func alignToMany(attributes: [NSLayoutAttribute], toView view: UIView, withOffsets offsets: [CGFloat]) {
        guard attributes.count == offsets.count else { return }
        var index = 0
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: offsets[index])
            view.addConstraint(constraint)
            index += 1
        }
    }
    
    /**
     Aligns multiple attributes between two views. Aligns evenly with no offset.
     - Parameters:
        - attributes: an array of the desired NSLayoutAttributes that you would like to align
        - view: the view with the desired position and attribute that you would like to align with
     */
    
    func alignToMany(attributes: [NSLayoutAttribute], toView view: UIView) {
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    
    // MARK: - Constraints
    
    /**
     Constrains two attributes to a specific ratio.
     - Parameters:
        - attribute: the desired NSLayoutAttribute that you would like to constrain.
        - view: the view with the desired position and attribute that you would like to constrain.
        - multiplier: the ratio by which the attributes will be proportionate to.
     */
    
    func constrain(attribute: NSLayoutAttribute, toView view: UIView, withMultiplier multiplier: CGFloat) {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: multiplier, constant: 0)
        view.addConstraint(constraint)
    }
    
    /**
     Constrains multiple attributes to a specific ratio. Must have same number of attributes and multipliers
     - Parameters:
        - attributes: an array of the desired NSLayoutAttributes that you would like to constrain.
        - view: the view with the desired position and attribute that you would like to constrain.
        - multipliers: the ratio by which the attributes will be proportionate to.
     */
    
    func constrainToMany(attributes: [NSLayoutAttribute], toView view: UIView, withMultiplers multipliers: [ConstraintPercentage]) {
        guard attributes.count == multipliers.count else { return }
        var index = 0
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: CGFloat(multipliers[index].rawValue), constant: 0)
            view.addConstraint(constraint)
            index += 1
        }
    }
    
    /**
     Constrains multiple attributes to a specific ratio and with a specific offset. Must have same number of attributes, multipliers, and offsets
     - Parameters:
        - attributes: an array of the desired NSLayoutAttributes that you would like to constrain.
        - view: the view with the desired position and attribute that you would like to constrain.
        - multipliers: the ratios by which the attributes will be proportionate to.
        - offsets: the number of points by which the views will be offset.
     */
    
    func constrainToMany(attributes: [NSLayoutAttribute], toView view: UIView, withMultiplers multipliers: [ConstraintPercentage], andOffsets offsets: [CGFloat]) {
        guard attributes.count == multipliers.count && attributes.count == offsets.count else { return }
        var index = 0
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: CGFloat(multipliers[index].rawValue), constant: offsets[index])
            view.addConstraint(constraint)
            index += 1
        }
    }
    
    /**
     Constrains the .Leading edge of self to the .Trailing edge of specified view
     - Parameters:
        - view: the view with the .Trailing edge to which you will be constraining
        - offset: the amount of points by which to seperate the constraint
     */
    
    func constrainLeadingToTrailing(ofView view: UIView, withOffset offset: CGFloat = 0.0) {
        let constraint = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: offset)
        view.addConstraint(constraint)
    }
    
    /**
     Constrains the .Trailing edge of self to the .Leading edge of specified view
     - Parameters:
        - view: the view with the .Leading edge to which you will be constraining
        - offset: the amount of points by which to seperate the constraint
     */
    
    func constrainTrailingToLeading(ofView view: UIView, withOffset offset: CGFloat = 0.0) {
        let constraint = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: offset)
        view.addConstraint(constraint)
    }
    
    /**
     Constrains the .Top edge of self to the .Bottom edge of specified view
     - Parameters:
        - view: the view with the .Bottom edge to which you will be constraining
        - offset: the amount of points by which to seperate the constraint
     */
    
    func constrainTopToBottom(ofView view: UIView, withOffset offset: CGFloat = 0.0) {
        let constraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: offset)
        view.addConstraint(constraint)
    }
    
    /**
     Constrains the .Bottom edge of self to the .Top edge of specified view
     - Parameters:
        - view: the view with the .Top edge to which you will be constraining
        - offset: the amount of points by which to seperate the constraint
     */
    
    func constrainBottomToTop(ofView view: UIView, withOffset offset: CGFloat = 0.0) {
        let constraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: offset)
        view.addConstraint(constraint)
    }
    
    
    
    
    

    
}


