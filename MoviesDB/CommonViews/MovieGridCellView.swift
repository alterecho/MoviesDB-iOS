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
        if movie.isLoading {
            ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let posterImage = movie.posterImage {
            Image(uiImage: posterImage).resizable().frame(width: size.width, height: size.height, alignment: .center).scaledToFit()
        } else {
            Image(Images.errorIcon).resizable().scaledToFit().frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    init(movie: Movie, size: CGSize) {
        _movie = StateObject(wrappedValue: movie)
        self.size = size
    }
}
