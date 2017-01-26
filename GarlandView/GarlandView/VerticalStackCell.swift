//
//  VerticalStackCell.swift
//  GarlandView
//
//  Created by Abdurahim Jauzee on 20/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit


class VerticalStackCell: UICollectionViewCell {
    
    @IBOutlet var infoLabel: UILabel! = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.textColor = .white
        contentView.addSubview(infoLabel)
        clipsToBounds = false
        contentView.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        infoLabel.frame = contentView.frame
    }
    
}
