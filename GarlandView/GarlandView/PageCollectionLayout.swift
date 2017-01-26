//
//  PageCollectionLayout.swift
//  TestCollectionView
//
//  Created by Alex K. on 04/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

private typealias VisibleCells = (going: PageCollectionViewCell, coming: PageCollectionViewCell)

public class PageCollectionLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    fileprivate var lastCollectionViewSize: CGSize = .zero
    fileprivate var currentOffsetX: CGFloat = 0
    fileprivate var lastOffsetX: CGFloat = 0
    
    fileprivate var cameCell: PageCollectionViewCell?
    fileprivate var goneCell: PageCollectionViewCell?
    
    fileprivate var shouldListenToBoundsChange = true
    
    var scalingOffset: CGFloat = 200
    var minimumScaleFactor: CGFloat = 0.95
    var minimumAlphaFactor: CGFloat = 0.4
    var scaleItems: Bool = true
    
}

// MARK: override

extension PageCollectionLayout {
    
    override open func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        
        guard let collectionView = self.collectionView else { return }
        
        if collectionView.bounds.size != lastCollectionViewSize {
            self.lastCollectionViewSize = collectionView.bounds.size
        }
    }
    
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        print(#function, proposedContentOffset, velocity)
        lastOffsetX = proposedContentOffset.x
        
//        let width = UIScreen.main.bounds.width
//        let offset = CGPoint(x: proposedContentOffset.x + width, y: 0)
        
        return proposedContentOffset
        
        
        /*
        guard let collectionView = self.collectionView else {
            return proposedContentOffset
        }
        
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
        guard let layoutAttributes = self.layoutAttributesForElements(in: proposedRect) else {
            return proposedContentOffset
        }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
        
        for attributes in layoutAttributes {
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            
            if fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attributes
            }
        }
        
        guard let aCandidateAttributes = candidateAttributes else {
            return proposedContentOffset
        }
        
        var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
        let offset = newOffsetX - collectionView.contentOffset.x
        
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = self.itemSize.width + self.minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
        */
    }
    
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        print(#function, newBounds)
        
        let scrollingToRight = newBounds.minX > currentOffsetX
        currentOffsetX = newBounds.minX
        
        if shouldListenToBoundsChange {
            let newOffset = newBounds.minX - lastOffsetX
            
            if let visibleCells = visibleCells(for: newBounds, isScrolllingToRight: scrollingToRight) {
                visibleCells.coming.animateVisibleCells(newOffset: newOffset, comingCell: true)
                visibleCells.going.animateVisibleCells(newOffset: newOffset, comingCell: false)
            }
            
//            if abs(newOffset) >= 100 {
//                guard let collectionView = self.collectionView else { return true }
//                shouldListenToBoundsChange = false
//                
//                let width = collectionView.bounds.width
//                let newOffsetX = scrollingToRight ? lastOffsetX - width : lastOffsetX + width
//                let newOffset = CGPoint(x: newOffsetX, y: 0)
//                collectionView.setContentOffset(newOffset, animated: true)
//            }
        }
        
        guard let width = collectionView?.bounds.width else { return true }
        if newBounds.minX.truncatingRemainder(dividingBy: width) == 0 {
            print("END SCROLLING")
//            shouldListenToBoundsChange = true
            cameCell?.resetVisibleCells(animated: true)
            goneCell?.resetVisibleCells(animated: false)
        }
        
        return true
    }
    
    /*
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        print(#function, rect)
        guard let collectionView = self.collectionView,
            let superAttributes = super.layoutAttributesForElements(in: rect) else {
                return super.layoutAttributesForElements(in: rect)
        }
        
        if scaleItems == false {
            return super.layoutAttributesForElements(in: rect)
        }
        
        let contentOffset = collectionView.contentOffset
        let size = collectionView.bounds.size
        
        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX
        
        guard case let newAttributesArray as [UICollectionViewLayoutAttributes] = NSArray(array: superAttributes, copyItems: true) else {
            return nil
        }
        
        newAttributesArray.forEach {
            let distanceFromCenter = visibleCenterX - $0.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), self.scalingOffset)
            let scale = absDistanceFromCenter * (self.minimumScaleFactor - 1) / self.scalingOffset + 1
            $0.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
 
            let alpha = absDistanceFromCenter * (self.minimumAlphaFactor - 1) / self.scalingOffset + 1
            $0.alpha = alpha
        }
        
        return newAttributesArray
    }
    */
    
}

// MARK: - Helers
private extension PageCollectionLayout {
    
    func visibleCells(for rect: CGRect, isScrolllingToRight: Bool) -> VisibleCells? {
        guard
            let collectionView = self.collectionView,
            let attributes = layoutAttributesForElements(in: rect) else { return nil }
        var cells: [PageCollectionViewCell] = []
        for attribute in attributes {
            let path = attribute.indexPath
            guard let cell = collectionView.cellForItem(at: path) as? PageCollectionViewCell else { continue }
            cells.append(cell)
        }
        
        guard cells.count == 2 else { return nil }
        
        let coming = isScrolllingToRight ? cells[1] : cells[0]
        let going = isScrolllingToRight ? cells[0] : cells[1]
        cameCell = coming
        goneCell = going
        
        let visibleCells = VisibleCells(going: going, coming: coming)
        return visibleCells
    }
    
}
