//
//  PhotosViewController.swift
//  Photorama
//
//  Created by xionghao on 2019/9/19.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var store: PhotoStore!
    
    var photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 根据当前列表的item位置获取photos的对应photo
        let photo = photoDataSource.photos[indexPath.row]
        
        // 根据photo获取image
        store.fetchImage(photo: photo) { (result) -> Void in
            guard
                // 确保当前indexPath位置上有之前取出的photo对象，可能滑动
                let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                // 确保下载图片成功
                case let .success(image) = result
                else {
                // 否则不显示图片
                return
            }
            
            let index = IndexPath(row: photoIndex, section: 0)
            // ItemView可见时才显示图片
            if let cell = collectionView.cellForItem(at: index) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as? PhotoPreviewViewController
                destinationVC?.photo = photo
                destinationVC?.photoStore = store
            }
        default:
            preconditionFailure("Unexcepted segue identifier")
        }
    }
    
}
