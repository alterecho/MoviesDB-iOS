//
//  MovieDetails.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import Foundation

class MovieDetails {
    let title: String?
    let year: String?
    let categories: String?
    let runtime: String?
    let ratings: String?
    let synopsis: String?
    let score: String?
    let reviews: String?
    let popularity: String?
    let director: String?
    let writer: String?
    let actors: String?
    
    init(response: MovieDetailsResponse) {
        self.title = response.Title
        self.year = response.Year
        self.categories = response.Genre
        self.runtime = response.Runtime
        self.ratings = response.imdbRating
        self.synopsis = response.Plot
        self.score = response.imdbRating
        self.reviews = response.imdbVotes
        self.popularity = response.imdbVotes
        self.director = response.Director
        self.writer = response.Writer
        self.actors = response.Actors
    }
}
