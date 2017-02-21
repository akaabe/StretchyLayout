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
    
    override init() {
        super.init()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        self.itemSize = CGSize(width: 320, height: 44)
        self.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        scrollResistanceDenominator = 1800
        contentOverflowPadding = UIEdgeInsetsMake(100, 0, 100, 0)
        bufferedContentInsets = contentOverflowPadding
        bufferedContentInsets.top *= -1
        bufferedContentInsets.bottom *= -1
    }
    
    override func prepare() {
        super.prepare()
    }
    
    override var collectionViewContentSize : CGSize {
        var contentSize = super.collectionViewContentSize
        contentSize.height += contentOverflowPadding.top + contentOverflowPadding.bottom
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let rect = UIEdgeInsetsInsetRect(rect, bufferedContentInsets)
        let items = super.layoutAttributesForElements(in: rect)
        for item in items! {
            var center: CGPoint = item.center
            center.y += contentOverflowPadding.top
            item.center = center
        }
        
        let collectionViewHeight:CGFloat = collectionViewContentSizeWithoutOverflow().height
        let topOffset:CGFloat = contentOverflowPadding.top
        let bottomOffset: CGFloat = collectionViewHeight - (self.collectionView?.frame.size.height)! + contentOverflowPadding.top
        let yPosition: CGFloat = (self.collectionView?.contentOffset.y)!
        
        if (yPosition < topOffset) {
            let stretchDelta: CGFloat = topOffset - yPosition
            for item in items! {
                let distanceFromTop = item.center.y - contentOverflowPadding.top
                let scrollResistane = distanceFromTop / scrollResistanceDenominator
                item.transform = CGAffineTransform(translationX: 0, y: -stretchDelta + (stretchDelta * scrollResistane))
            }
            
            transformsNeedReset = true
        }
        
        else if (yPosition > bottomOffset) {
            let stretchDelta = yPosition - bottomOffset
            
            for item in items! {
                let distanceFromBottom: CGFloat = collectionViewHeight + contentOverflowPadding.top
                - item.center.y
                let scrollResistance: CGFloat = distanceFromBottom / scrollResistanceDenominator
                item.transform = CGAffineTransform(translationX: 0, y: stretchDelta + (-stretchDelta * scrollResistance))
                
                transformsNeedReset = true
            }
        }
        
        else if (transformsNeedReset) {
            transformsNeedReset = false
            
            for item in items! {
                item.transform = CGAffineTransform.identity
            }
        }
        
        return items
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func collectionViewContentSizeWithoutOverflow()->CGSize {
        return super.collectionViewContentSize
    }
}
