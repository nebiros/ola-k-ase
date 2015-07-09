//
//  SpringFlowLayout.swift
//  OlaKAse
//
//  Created by Juan Felipe Alvarez Saldarriaga on 7/8/15.
//  Copyright © 2015 Juan Felipe Alvarez Saldarriaga. All rights reserved.
//

import UIKit

class SpringFlowLayout: UICollectionViewFlowLayout {
    
    var scrollResistanceFactor: CGFloat = 0.0
    var dynamicAnimator: UIDynamicAnimator?
    var visibleIndexPathsSet: Set<NSIndexPath>?
    var visibleHeaderAndFooterSet: Set<NSIndexPath>?
    var latestDelta: CGFloat = 0.0
    var interfaceOrientation: UIInterfaceOrientation?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
        visibleIndexPathsSet = Set<NSIndexPath>()
        visibleHeaderAndFooterSet = Set<NSIndexPath>()
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        if UIApplication.sharedApplication().statusBarOrientation != interfaceOrientation {
            dynamicAnimator!.removeAllBehaviors()
            visibleIndexPathsSet = Set<NSIndexPath>()
        }
        
        interfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        
    }
}
