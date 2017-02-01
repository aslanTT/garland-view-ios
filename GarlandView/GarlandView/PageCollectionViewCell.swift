//
//  PageCollectionViewCell.swift
//  GarlandView
//
//  Created by Abdurahim Jauzee on 20/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import Foundation
import UIKit


public class PageCollectionViewCell: UICollectionViewCell {
    
    var tableView: UITableView!
    var collectionView: UICollectionView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        clipsToBounds = false
        layer.masksToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: VerticalStackLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(VerticalStackCell.self)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.layer.masksToBounds = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(collectionView)
    }
    
    var visibleCells: [VerticalStackCell] {
        return (collectionView.visibleCells as? [VerticalStackCell] ?? []).sorted { $0.frame.origin.y < $1.frame.origin.y }
    }
    
    func animateVisibleCells(newOffset: CGFloat, comingCell: Bool) {
        let maxOffset = UIScreen.main.bounds.width / 2
        let completionPercent = abs(newOffset) * 100 / maxOffset
        
        let goingToRight = newOffset < 0
        
        let maxWidth = collectionView.bounds.width
        let cells = visibleCells
        
        var alpha = max(0.2, 1 * completionPercent / 100)
        if !comingCell {
            alpha = max(0.2, abs(1.0 - alpha))
        }
        
        var index: CGFloat = 1
        for cell in cells {
            let offsetX = goingToRight ? abs(newOffset) : -newOffset
            let x = (offsetX/4) / index
            print(x)
            cell.transform = CGAffineTransform(translationX: x, y: 0)
            cell.infoLabel.text = "offset: \(newOffset)\ncompletion: \(round(completionPercent))\nto right: \(goingToRight)\nis coming: \(comingCell)"
            index += 2
        }
    }
    
    func resetVisibleCells(animated: Bool) {
        for cell in visibleCells {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    cell.transform = CGAffineTransform.identity
                    cell.alpha = 1
                }
            } else {
                cell.transform = CGAffineTransform.identity
                cell.alpha = 1
            }
        }
    }
    
}

extension PageCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(VerticalStackCell.self, for: indexPath)
        cell.infoLabel.text = "row #\(indexPath.row + 1)"
        cell.contentView.backgroundColor = .random
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
}

/*
extension VerticalCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(StackCardCell.self)
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.5683954358, green: 0.8634789586, blue: 0.9851445556, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        cell.testLabel.text = "row #\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
*/
