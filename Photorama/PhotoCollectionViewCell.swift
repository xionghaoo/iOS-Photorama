//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by xionghao on 2019/9/25.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Main.storyboard和插座变量关联时调用
        update(with: nil)
        print("awakeFromNib")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 重用子视图前调用
        update(with: nil)
        print("prepareForReuse")
    }
    
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            loadingView.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            loadingView.startAnimating()
            imageView.image = nil
        }
    }
}
