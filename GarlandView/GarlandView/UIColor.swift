//
//  UIColor.swift
//  GarlandView
//
//  Created by Abdurahim Jauzee on 23/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit


extension UIColor {
    
    private convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class var random: UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
}
