//
//  MovieDetailsResponse.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import Foundation

struct RatingsResponse: Decodable {
    let source: String?
    let value: String?
    
    enum codingKeys: String, CodingKey {
        case source = "source"
        case value = "Value"
    }
}

struct MovieDetailsResponse: Decodable {
    let Title: String?
    let Year: String?
    let Rated: String?
    let Released: String?
    let Runtime: String?
    let Genre: String?
    let Director: String?
    let Writer: String?
    let Actors: String?
    let Plot: String?
    let Language: String?
    let Country: String?
    let Awards: String?
    let Poster: URL?
    let Ratings: [RatingsResponse]?
    let Metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let `Type`: String?
    let DVD: String?
    let boxOffice: String?
    let Production: String?
    let Website: String?
    let Response: String?
}
