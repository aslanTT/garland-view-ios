//
//  UIEdgeInsets.swift
//  GarlandView
//
//  Created by Abdurahim Jauzee on 20/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit


extension UIEdgeInsets {
    
    public init(_ padding: CGFloat, sidePadding: CGFloat = 0) {
        top = padding; bottom = padding
        left = sidePadding; right = sidePadding
    }
    
    public init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil, otherSides: CGFloat? = nil) {
        self.top = top ?? otherSides ?? 0
        self.left = left ?? otherSides ?? 0
        self.bottom = bottom ?? otherSides ?? 0
        self.right = right ?? otherSides ?? 0
    }
    
}
