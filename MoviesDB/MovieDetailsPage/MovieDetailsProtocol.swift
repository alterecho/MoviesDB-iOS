//
//  MovieDetailsProtocol.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 3/3/22.
//

import UIKit

protocol MovieDetailsViewModelProtocol: ObservableObject {
    
    var service: MovieDetailsViewServiceProtocol { get set }
    
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
    var alert: AlertModel { get set }
    var isLoading: Bool { get }
    func onAppear()
}

protocol MovieDetailsViewServiceProtocol {
    func fetchMovieDetails(id: String, completionHandler: @escaping (Result<MovieDetails, Error>) -> Void)
}

