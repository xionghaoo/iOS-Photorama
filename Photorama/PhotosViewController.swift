//
//  PhotosViewController.swift
//  Photorama
//
//  Created by xionghao on 2019/9/19.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var store: PhotoStore!
    
    var photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        
        store.fetchInterestingPhotos { (photosResult) -> Void in
            switch (photosResult) {
            case let .success(photos):
                print("请求成功：photos size = \(photos.count)")
//                if let firstPhoto = photos.first {
//                    self.updateImageView(with: firstPhoto)
//                }
                self.photoDataSource.photos = photos
            case let .failure(e):
                print("请求失败：error: \(e.localizedDescription)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
}
