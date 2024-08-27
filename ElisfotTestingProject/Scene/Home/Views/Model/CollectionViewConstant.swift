//
//  CollectionViewConstant.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import Foundation

final class CollectionViewHelper {
    static let itemsPerRow: CGFloat = 7
    static let totalRows: CGFloat = 10
    static let spacing: CGFloat = 2
    
    static private func getTotalWSpacing() -> CGFloat {
        return (itemsPerRow - 1) * spacing
    }
    
    static private func getTotalHSpacing() -> CGFloat {
        return (totalRows - 1) * spacing
    }
    
    static func getCellHeight(collectViewHeight: CGFloat) -> CGFloat {
        let totalHSpacing = (totalRows - 1) * spacing
        let itemHeight: Double = (collectViewHeight - totalHSpacing) / Double(totalRows)
        
        return itemHeight
    }
    
    static func getCellWidth(collectViewWidth: CGFloat) -> CGFloat {
        let totalWSpacing = (itemsPerRow - 1) * spacing
        let itemWidth = (collectViewWidth - totalWSpacing) / itemsPerRow
        
        return itemWidth
    }
}
