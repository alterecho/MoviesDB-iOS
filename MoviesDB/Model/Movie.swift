//
//  MovieModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import Foundation

struct Movie: Codable, Hashable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: Type?
    let posterURL: URL?
    
    init(response: MovieResponse) {
        self.title = response.title
        self.year = response.year
        self.imdbID = response.imdbID
        self.type = response.type
        self.posterURL = response.poster
    }
}
