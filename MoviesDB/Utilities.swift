//
//  Utilities.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import UIKit
import Combine

class Utilities {
    static let shared = Utilities()
    
    private var cancellables = [AnyCancellable]()
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    func downloadImage(url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        var image = imageCache.object(forKey: url as NSURL)
        if let image = image {
            completionHandler(.success(image))
            return
        }
        URLSession.shared.dataTaskPublisher(for: url).map { resp in
            return UIImage(data: resp.data)
        }.receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                if let image = image {
                    completionHandler(.success(image))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
                break
            }
        }, receiveValue: { [weak self] downloadedImage in
            image = downloadedImage
            if let downloadedImage = downloadedImage {
                self?.imageCache.setObject(downloadedImage, forKey: url as NSURL)
            }
        }).store(in: &cancellables)
    }
}
