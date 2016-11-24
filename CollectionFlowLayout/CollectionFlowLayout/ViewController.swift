//
//  ViewController.swift
//  CollectionFlowLayout
//
//  Created by use on 16/6/29.
//  Copyright © 2016年 wjp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellCount = 10;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.whiteColor();
        setCircleLayout();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCircleLayout() {
        let layout = WJPCircleLayout();
        collectionView?.collectionViewLayout = layout;
    }
    
    @IBAction func startRun(sender: UIButton) {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(run) , userInfo: nil, repeats: true);
    }
    
    @objc private func run() {
        for i in 0..<cellCount {
            let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0));
            let nextI = i == cellCount-1 ? 0 : i+1;
            
            let nextcell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: nextI, inSection: 0));
            
            UIView.animateWithDuration(0.1, animations: {
                let layout = self.collectionView.collectionViewLayout;
                let angle = layout.valueForKey("angle")!.floatValue;
                let radius = layout.valueForKey("radius");
                let attri = self.collectionView.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0));
                cell!.center = CGPoint(x: attri!.center.x + radius!*cos(angle!), y: attri.center.y + radius*sin(angle));
            });
        }
    }
}

extension ViewController {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellId", forIndexPath: indexPath);
        return cell;
    }
}