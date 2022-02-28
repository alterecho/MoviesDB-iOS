//
//  MovieDetailsViewModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import Foundation
import UIKit

protocol MovieDetailsViewModelProtocol: ObservableObject {
    var pageTitle: String { get }
    var synopsisTitle: String { get }
    var scoreTitle: String { get }
    var reviewTitle: String { get }
    var popularityTitle: String { get }
    var directorTitle: String { get }
    var writerTitle: String { get }
    var actorsTitle: String { get }    
    
    var details: MovieDetails? { get }
    
    var poster: UIImage? { get }
    
    func onAppear()
}

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
    
    @Published private(set) var details: MovieDetails?
    @Published private(set) var poster: UIImage?
    
    private let service = MovieDetailsViewService()
    
    init(imdbID: String) {
        self.imdbID = imdbID
    }
    
    func onAppear() {
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
