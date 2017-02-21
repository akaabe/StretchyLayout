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

        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.indicatorStyle = UIScrollViewIndicatorStyle.default
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

