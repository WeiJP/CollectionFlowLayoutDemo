//
//  WJPCircleLayout.swift
//  CollectionFlowLayout
//
//  Created by use on 16/6/29.
//  Copyright © 2016年 wjp. All rights reserved.
//

import UIKit

class WJPCircleLayout: UICollectionViewLayout {
    
    var totalCount = 0;
    var center = CGPointZero;
    var radius: CGFloat = 0.0;
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = [];
    
    
    override func prepareLayout() {
        super.prepareLayout();
        totalCount = collectionView!.numberOfItemsInSection(0);
        layoutAttributes = [];
        center = CGPoint(x: Double(collectionView!.bounds.width*0.5), y: Double(collectionView!.bounds.height*0.5));
        radius = min(collectionView!.bounds.width, collectionView!.bounds.height) / 3.0;
        
        var indexPath : NSIndexPath;
        for index in 0..<totalCount {
            indexPath = NSIndexPath(forRow: index, inSection: 0);
            let attributes = layoutAttributesForItemAtIndexPath(indexPath)!
            layoutAttributes.append(attributes);
        }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath);
        attributes.size = CGSize(width: 60.0, height: 60.0);
        let angle = 2 * CGFloat(M_PI) * CGFloat(indexPath.row) / CGFloat(totalCount);
        attributes.center = CGPoint(x: center.x + radius*cos(angle), y: center.y + radius*sin(angle));
        return attributes;
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes;
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.bounds.size;
    }
    
    
}
