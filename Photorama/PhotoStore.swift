//
//  PhotoStore.swift
//  Photorama
//
//  Created by xionghao on 2019/9/19.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

class PhotoStore {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            let result = self.proccessPhotosRequest(with: data, error: error)
            OperationQueue.main.addOperation {
                 completion(result)
            }
        }
        task.resume()
    }
    
    private func proccessPhotosRequest(with data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    func fetchImage(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let request = URLRequest(url: photo.remoteURL)
        session.dataTask(with: request) { (data, response, error) -> Void in
            let result = self.proccessImageRequest(with: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }.resume()
    }
    
    private func proccessImageRequest(with data: Data?, error: Error?) -> ImageResult {
        if let imageData = data, let image = UIImage(data: imageData) {
            return .success(image)
        } else {
            return .failure(PhotoError.imageCreationError)
        }
    }
    
}
