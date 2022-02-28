//
//  MoviesListViewService.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 27/2/22.
//

import Combine
import Foundation

class MoviesListViewService {
    var searchCancellable: AnyCancellable?
    
    func search(_ searchString: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        guard searchCancellable == nil else {
            return
        }
        var movies = [Movie]()
        let request = URLRequest(url: API.fetchMoviesURL(searchText: searchString))
        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main).sink { [weak self] completion in
                self?.searchCancellable = nil
                switch completion {
                case .finished:
                    completionHandler(.success(movies))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            } receiveValue: { response in
                movies = response.search?.map { response in
                    return Movie(response: response)
                } ?? []
            }
    }
}
