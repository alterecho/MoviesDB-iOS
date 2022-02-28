//
//  MovieDetailsViewService.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import Foundation
import Combine

class MovieDetailsViewService {
    private var movieDetailsCancellable: AnyCancellable?
    func fetchMovieDetails(id: String, completionHandler: @escaping (Result<MovieDetails, Error>) -> Void) {
        var movieDetails: MovieDetails?
        let url = API.fetchMoviesDetails(id: id)
        movieDetailsCancellable = URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: MovieDetailsResponse.self, decoder: JSONDecoder())    
        .sink { completion in
            switch completion {
            case .finished:
                if let movieDetails = movieDetails {
                    completionHandler(.success(movieDetails))
                }
            case .failure(_):
                break
            }
        } receiveValue: { response in
            movieDetails = MovieDetails(response: response)
        }
    }
}
