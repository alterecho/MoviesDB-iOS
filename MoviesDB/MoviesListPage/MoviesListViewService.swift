//
//  MoviesListViewService.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 27/2/22.
//

import Combine
import Foundation

class MoviesListViewService: MoviesListViewServiceProtocol {
    var searchCancellable: AnyCancellable?
    
    func search(_ searchString: String, page: Int, completionHandler: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard searchCancellable == nil else {
            return
        }
        let request = URLRequest(url: API.fetchMoviesURL(searchText: searchString, page: page))
        var searchResponse: SearchResponse?
        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main).sink { [weak self] completion in
                self?.searchCancellable = nil
                switch completion {
                case .finished:
                    if let response = searchResponse {
                        completionHandler(.success(response))
                    } else {
                        completionHandler(.failure(NSError()))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            } receiveValue: { response in
                searchResponse = response
            }
    }
}
