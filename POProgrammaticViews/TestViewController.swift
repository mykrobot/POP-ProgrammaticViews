//
//  TestViewController.swift
//  POProgrammaticViews
//
//  Created by Michael Mecham on 9/20/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//



import UIKit

class TestViewController: UIViewController {
    
    var firstView = CustomView()
    var secondView = CustomView()
    var thirdView = CustomView()
    var fourthView = CustomView()
    var fifthView = CustomView()
    var sixthView = CustomView()
    var firstLabel = CustomLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewsAsSubviews()
        setColors()
        layoutConstraints()
        setLabelText()
    }
    func addViewsAsSubviews() {
        firstView.addTo(self.view)
        secondView.addTo(self.view)
        thirdView.addTo(secondView)
        fourthView.addTo(secondView)
        fifthView.addTo(secondView)
        sixthView.addTo(secondView)
        firstLabel.addTo(thirdView)
    }
    
    func setColors() {
        firstView.backgroundColor = .redColor()
        secondView.backgroundColor = .blackColor()
        thirdView.backgroundColor = UIColor.cyanColor().colorWithAlphaComponent(0.75)
        fourthView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.75)
        fifthView.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.75)
        sixthView.backgroundColor = UIColor.purpleColor().colorWithAlphaComponent(0.75)
    }
    
    func setLabelText() {
        firstLabel.text = "Next"
        firstLabel.textAlignment = .Center
    }
    
    func layoutConstraints() {
        firstView.alignAllEdgesTo(self.view)
        secondView.alignToMany([.Top, .Leading, .Trailing, .Bottom], toView: self.view, withOffsets: [20, 20, -20, -20])
        
        thirdView.alignToMany([.Top, .Leading], toView: secondView, withOffsets: [8, 8])
        thirdView.constrainToMany([.Height, .Width], toView: secondView, withMultiplers: [.Half, .Half], andOffsets: [-12, -12])
        
        fourthView.alignToMany([.Top, .Trailing], toView: secondView, withOffsets: [8, -8])
        fourthView.constrainToMany([.Height, .Width], toView: secondView, withMultiplers: [.Half, .Half], andOffsets: [-12, -12])
        
        fifthView.alignToMany([.Bottom, .Trailing], toView: secondView, withOffsets: [-8, -8])
        fifthView.constrainToMany([.Height, .Width], toView: secondView, withMultiplers: [.Half, .Half], andOffsets: [-12, -12])
        
        firstLabel.alignAllEdgesTo(thirdView)
        
    }
    
}












