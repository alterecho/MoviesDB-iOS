//
//  MovieDetailsServiceMock.swift
//  MoviesDBTests
//
//  Created by Vijaychandran Jayachandran on 3/3/22.
//

import Foundation
@testable import MoviesDB

class MockDetailsViewService: MovieDetailsViewServiceProtocol {
    var fetchMovieDetailsCalled = false
    func fetchMovieDetails(id: String, completionHandler: @escaping (Result<MovieDetails, Error>) -> Void) {
    }
     
}
