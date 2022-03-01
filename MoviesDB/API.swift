//
//  URLs.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import Foundation

struct API {
    private static let baseURL = "http://www.omdbapi.com"
    
    private static let apiKey = "b9bd48a6"
    
    private static let defaultSearchText = "Marvel"
    private static let defaultType = "movie"
    
    static func fetchMoviesURL(searchText s: String = defaultSearchText, page: Int) -> URL {
        guard let url = URL(string: "\(baseURL)/?apikey=\(apiKey)&s=\(s)&type=\(defaultType)&page=\(page)") else {
            fatalError("invalid MoviesURL")
        }
        return url
    }
    
    static func fetchMoviesDetails(id: String) -> URL {
        guard let url = URL(string: "\(baseURL)/?apikey=\(apiKey)&i=\(id)") else {
            fatalError("invalid MoviesURL")
        }
        return url
    }
}
