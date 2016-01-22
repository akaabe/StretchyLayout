//
//  ViewController.swift
//  StretchyLayout
//
//  Created by Dmytro on 1/6/16.
//  Copyright © 2016 Dmytro. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    
    let cellIdentifier = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.delegate = self
        self.collectionView?.clipsToBounds = false

        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.indicatorStyle = UIScrollViewIndicatorStyle.Default
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) ->Int
    {
        return 20
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 1
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

