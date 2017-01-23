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
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = PageCollectionLayout()
        let itemHeight = collectionView.bounds.height
        let itemWidth = collectionView.bounds.width
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0

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
