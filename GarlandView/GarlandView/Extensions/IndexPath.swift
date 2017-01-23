//
//  IndexPath.swift
//  GarlandView
//
//  Created by Abdurahim Jauzee on 22/01/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import Foundation


extension IndexPath {
    
    var prevItem: IndexPath {
        return IndexPath(item: item - 1, section: section)
    }
    
    var nextItem: IndexPath {
        return IndexPath(item: item + 1, section: section)
    }
    
    var prevRow: IndexPath {
        return IndexPath(row: row - 1, section: section)
    }
    
    var nextRow: IndexPath {
        return IndexPath(row: row + 1, section: section)
    }
    
}
