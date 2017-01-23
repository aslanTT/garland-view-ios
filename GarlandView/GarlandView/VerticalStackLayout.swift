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
        scrollDirection = .vertical
        sectionInset = .zero
        minimumInteritemSpacing = itemSpacing / 2
        minimumLineSpacing = itemSpacing / 2
    }
    
}
    }
    
}
