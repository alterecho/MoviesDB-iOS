//
//  MovieModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import Foundation

struct MovieResponse: Codable, Hashable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: Type?
    let poster: URL?
        
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "ImdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
