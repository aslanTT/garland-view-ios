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
        clipsToBounds = false
        contentView.clipsToBounds = false
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: VerticalStackLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(VerticalStackCell.self)
        collectionView.backgroundColor = UIColor.white
        collectionView.clipsToBounds = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(collectionView)
        
        /*
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(StackCardCell.self)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(tableView)
        */
    }
    
    var visibleCells: [VerticalStackCell] {
        return (collectionView.visibleCells as? [VerticalStackCell] ?? []).sorted { $0.frame.origin.y < $1.frame.origin.y }
    }
    
    func animateVisibleCells(newOffset: CGFloat, comingCell: Bool) {
        let goingToRight = newOffset < 0
        
        let maxWidth = collectionView.bounds.width
        let completed = Int(abs(newOffset) * 100 / (maxWidth/3))
        
        let cells = visibleCells
        
        var index = CGFloat(cells.count)
        for cell in cells {
            var x = CGFloat((goingToRight ? completed : -completed)) * index
            
            if comingCell && index == CGFloat(cells.count) {
                x = x * 1.5
            }
            
            cell.transform = CGAffineTransform(translationX: x, y: 0)
//                .scaledBy(x: <#T##CGFloat#>, y: <#T##CGFloat#>)
            cell.infoLabel.text = "offset: \(newOffset)\ncompletion:\(completed)\nto right: \(goingToRight)\ntranslationX: \(x)\nis coming: \(comingCell)"
            index -= 1
        }
    }
    
    func resetVisibleCells(animated: Bool) {
        for cell in visibleCells {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    cell.transform = CGAffineTransform.identity
                }
            } else {
                cell.transform = CGAffineTransform.identity
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
