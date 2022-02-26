//
//  MovieModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import Foundation

struct Movie: Codable {
    let title: String
    let year: UInt
    let imdbID: String
    let type: Type?
    let poster: URL?
    
    init() {
        title = "title"
        year = 1023
        imdbID = "imdbID"
        type = .movie
        poster = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "ImdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
}
