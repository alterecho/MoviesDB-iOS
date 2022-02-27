//
//  SearchResponse.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 27/2/22.
//

import Foundation

struct SearchResponse: Decodable {
    let response: String?
    let search: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case response = "Response"
    }
}
