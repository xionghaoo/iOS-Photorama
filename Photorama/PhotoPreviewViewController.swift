//
//  PhotoPreviewViewController.swift
//  Photorama
//
//  Created by xionghao on 2019/9/25.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class PhotoPreviewViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var photoStore: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoStore.fetchImage(photo: photo) { (result) -> Void in
            switch (result) {
            case let .success(image):
                self.imageView.image = image
            case let .failure(e):
                print("图片加载错误：\(e)")
            }
        }
    }
}
