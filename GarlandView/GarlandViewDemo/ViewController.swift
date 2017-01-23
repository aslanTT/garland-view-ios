//
//  ViewController.swift
//  GarlandViewDemo
//
//  Created by Abdurahim Jauzee on 23/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit
import GarlandView

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: CollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = PageCollectionLayout()
        let maxHeight: CGFloat = collectionView.bounds.height
        let maxWidth = UIScreen.main.bounds.width
        let itemWidth = maxWidth * 0.8
        let itemSpacing = maxWidth * 0.2
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: maxHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = itemSpacing
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: 15,
                                               left: itemSpacing / 2,
                                               bottom: 15,
                                               right: itemSpacing / 2)

        collectionView.collectionViewLayout = flowLayout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PageCollectionViewCell.self), for: indexPath)
        return cell
    }
    
}
