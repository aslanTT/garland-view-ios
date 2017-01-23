//
//  CollectionView.swift
//  GarlandView
//
//  Created by Abdurahim Jauzee on 23/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit


open class CollectionView: UICollectionView {
    
    // MARK: Properties
    fileprivate var currentOffsetX: CGFloat = 0
    fileprivate var lastOffsetX: CGFloat = 0
    fileprivate var currentPageIndex = 0
    
    // MARK: Constructor
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        delegate = self
        dataSource = self
        register(PageCollectionViewCell.self)
    }
    
}

// MARK: - Helpers
private extension CollectionView {
    
    var visiblePageCells: [PageCollectionViewCell] {
        return visibleCells as? [PageCollectionViewCell] ?? []
    }
    
}


// MARK: - Delegate
extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: CollectionView
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(PageCollectionViewCell.self, for: indexPath)
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PageCollectionViewCell else { return }
        cell.resetVisibleCells(animated: false)
    }
    
    // MARK: ScrollView
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollingToRight = scrollView.contentOffset.x > currentOffsetX
        currentOffsetX = scrollView.contentOffset.x
        
        let newOffset = scrollView.contentOffset.x - lastOffsetX
        
        /*
        if abs(newOffset) > 100, !scrollView.isDecelerating {
            scrollView.panGestureRecognizer.require(toFail: scrollView.panGestureRecognizer)
            let maxWidth = scrollView.bounds.width
            let newOffsetX = scrollingToRight == true ? lastOffsetX + maxWidth : lastOffsetX - maxWidth
            let newOffsetPoint = CGPoint(x: newOffsetX, y: 0)
            scrollView.setContentOffset(newOffsetPoint, animated: true)
            for cell in visiblePageCells {
                cell.resetVisibleCells(animated: true)
            }
        } else {
            
        }
        */
        
        for cell in visiblePageCells {
            cell.animateVisibleCells(newOffset: newOffset)
        }
        
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        for cell in visiblePageCells {
            cell.resetVisibleCells(animated: true)
        }
        
        lastOffsetX = scrollView.contentOffset.x
        currentPageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}
