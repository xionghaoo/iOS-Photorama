//
//  PhotosViewController.swift
//  Photorama
//
//  Created by xionghao on 2019/9/19.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos()
    }
    
}
