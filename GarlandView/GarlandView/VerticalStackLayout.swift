//
//  VerticalStackLayout.swift
//  GarlandView
//
//  Created by Abdurahim Jauzee on 21/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit


class VerticalStackLayout: UICollectionViewFlowLayout {
    
    // MARK: Constructor
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let maxHeight: CGFloat = 150
        let maxWidth = UIScreen.main.bounds.width
        let itemWidth = maxWidth * 0.8
        let itemSpacing = maxWidth * 0.2
        
        itemSize = CGSize(width: itemWidth, height: maxHeight)
        sectionInset = UIEdgeInsets(top: 7.5, left: itemSpacing / 2, bottom: 7.5, right: itemSpacing / 2)
        scrollDirection = .vertical
        sectionInset = .zero
    }
    
}
