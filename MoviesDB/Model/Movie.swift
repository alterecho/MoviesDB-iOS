//
//  MovieModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import Foundation
import UIKit

class Movie: ObservableObject {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.imdbID == rhs.imdbID
    }
    
    let title: String?
    let year: String?
    let imdbID: String?
    let type: Type?
    
    let posterURL: URL?
    
    @Published var posterImage: UIImage?
    
    init(response: MovieResponse) {
        self.title = response.title
        self.year = response.year
        self.imdbID = response.imdbID
        self.type = response.type
        self.posterURL = response.poster
        
        downloadImage()
    }
    
    func downloadImage() {
        guard let posterURL = posterURL else {
            return
        }
        
        Utilities.shared.downloadImage(url: posterURL) { result in
            Utilities.shared.downloadImage(url: posterURL) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.posterImage = image
                case .failure(let error):
                    break
                }
            }
        }
    }
}
