//
//  MoviesListViewService.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 27/2/22.
//

import Combine
import Foundation

class MoviesListViewService {
    func search(_ searchString: String) -> AnyPublisher<[Movie], Error> {
        let request = URLRequest(url: API.fetchMoviesURL(searchText: searchString))
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { print($0.data.count); return $0.data }.decode(type: SearchResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
