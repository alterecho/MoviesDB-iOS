//
//  MovieDetailsViewModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import Foundation
import UIKit

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {    
    var pageTitle = "Details page"
    
    let imdbID: String
    
    var synopsisTitle = "Synopsis"
    var scoreTitle = "Score"
    var reviewTitle = "Review"
    var popularityTitle = "Popularity"
    var directorTitle = "Director"
    var writerTitle = "Writer"
    var actorsTitle = "Actors"
    
    @Published var alert = AlertModel()
    
    @Published private(set) var details: MovieDetails?
    @Published private(set) var poster: UIImage?
    @Published private(set) var isLoading = false
    
    var service: MovieDetailsViewServiceProtocol = MovieDetailsViewService()
    
    init(imdbID: String) {
        self.imdbID = imdbID
    }
    
    func onAppear() {
        isLoading = true
        service.fetchMovieDetails(id: imdbID) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let details):
                self?.details = details
                if let posterURL = details.posterURL {
                    Utilities.shared.downloadImage(url: posterURL) { result in
                        switch result {
                        case .success(let image):
                            self?.poster = image
                        case .failure(let error):
                            self?.alert = AlertModel(error: error)
                        }
                    }
                }
            case .failure(let error):
                self?.alert = AlertModel(error: error)
            }
        }
    }
}
