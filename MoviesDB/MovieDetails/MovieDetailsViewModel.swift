//
//  MovieDetailsViewModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import Foundation
import UIKit

protocol MovieDetailsViewModelProtocol: ObservableObject {
    var details: MovieDetails? { get }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    let imdbID: String
    
    @Published private(set) var details: MovieDetails?
    @Published private(set) var poster: UIImage?
    
    private let service = MovieDetailsViewService()
    
    init(imdbID: String) {
        self.imdbID = imdbID
        service.fetchMovieDetails(id: imdbID) { [weak self] result in
            switch result {
            case .success(let details):
                self?.details = details
                if let posterURL = details.posterURL {
                    Utilities.shared.downloadImage(url: posterURL) { result in
                        switch result {
                        case .success(let image):
                            self?.poster = image
                            break
                        case .failure(_):
                            break
                        }
                    }
                }
            case .failure(_):
                break
            }
        }
    }
}
