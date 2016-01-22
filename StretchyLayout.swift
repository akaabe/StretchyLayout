//
//  StretchyLayout.swift
//  StretchyLayout
//
//  Created by Dmytro on 1/6/16.
//  Copyright © 2016 Dmytro. All rights reserved.
//

import UIKit

class StretchyLayout: UICollectionViewFlowLayout
{
    var bufferedContentInsets: UIEdgeInsets!
    var transformsNeedReset: Bool = false
    var scrollResistanceDenominator: CGFloat = 0
    var contentOverflowPadding: UIEdgeInsets!
    
    override init()
    {
        super.init()
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        self.itemSize = CGSizeMake(320, 44)
        self.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        self.scrollResistanceDenominator = 500
        self.contentOverflowPadding = UIEdgeInsetsMake(100, 0, 100, 0)
        self.bufferedContentInsets = self.contentOverflowPadding
        self.bufferedContentInsets.top *= -1
        self.bufferedContentInsets.bottom *= -1
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        self.itemSize = CGSizeMake(320, 44)
        self.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        self.scrollResistanceDenominator = 1800
        self.contentOverflowPadding = UIEdgeInsetsMake(100, 0, 100, 0)
        self.bufferedContentInsets = self.contentOverflowPadding
        self.bufferedContentInsets.top *= -1
        self.bufferedContentInsets.bottom *= -1
    }
    
    override func prepareLayout()
    {
        super.prepareLayout()
    }
    
    override func collectionViewContentSize() -> CGSize
    {
        var contentSize = super.collectionViewContentSize()
        contentSize.height += self.contentOverflowPadding.top + self.contentOverflowPadding.bottom
        return contentSize
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        let rect = UIEdgeInsetsInsetRect(rect, self.bufferedContentInsets)
        let items = super.layoutAttributesForElementsInRect(rect)
        for item in items!
        {
            var center: CGPoint = item.center
            center.y += self.contentOverflowPadding.top
            item.center = center
        }
        
        let collectionViewHeight:CGFloat = self.collectionViewContentSizeWithoutOverflow().height
        let topOffset:CGFloat = self.contentOverflowPadding.top
        let bottomOffset: CGFloat = collectionViewHeight - (self.collectionView?.frame.size.height)! + self.contentOverflowPadding.top
        let yPosition: CGFloat = (self.collectionView?.contentOffset.y)!
        
        if (yPosition < topOffset)
        {
            let stretchDelta: CGFloat = topOffset - yPosition
            for item in items!
            {
                let distanceFromTop = item.center.y - self.contentOverflowPadding.top
                let scrollResistane = distanceFromTop / self.scrollResistanceDenominator
                item.transform = CGAffineTransformMakeTranslation(0, -stretchDelta + (stretchDelta * scrollResistane))
            }
            
            self.transformsNeedReset = true
        }
        
        else if (yPosition > bottomOffset)
        {
            let stretchDelta = yPosition - bottomOffset
            
            for item in items!
            {
                let distanceFromBottom: CGFloat = collectionViewHeight + self.contentOverflowPadding.top
                - item.center.y
                let scrollResistance: CGFloat = distanceFromBottom / self.scrollResistanceDenominator
                item.transform = CGAffineTransformMakeTranslation(0, stretchDelta + (-stretchDelta * scrollResistance))
                
                self.transformsNeedReset = true
            }
        }
        
        else if (self.transformsNeedReset)
        {
            self.transformsNeedReset = false
            
            for item in items!
            {
                item.transform = CGAffineTransformIdentity
            }
        }
        
        return items
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool
    {
        return true
    }
    
    func collectionViewContentSizeWithoutOverflow()->CGSize
    {
        return super.collectionViewContentSize()
    }
}
