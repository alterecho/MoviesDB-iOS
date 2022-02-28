//
//  File.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 27/2/22.
//

import SwiftUI

struct MovieGridCellView: View {
    @StateObject var movie: Movie
    let size: CGSize
    
    var body: some View {
        if let posterImage = movie.posterImage {
            Image(uiImage: posterImage).resizable().frame(width: size.width, height: size.height, alignment: .center).scaledToFit()
        } else {
            ProgressView().background(Color.red)
        }
    }
    
    init(movie: Movie, size: CGSize) {
        _movie = StateObject(wrappedValue: movie)
        self.size = size
    }
}
