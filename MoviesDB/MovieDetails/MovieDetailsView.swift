//
//  MovieDetailsView.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import SwiftUI

struct MovieDetailsView<ViewModel: MovieDetailsViewModelProtocol>: View {
    let viewModel: ViewModel
    
    var body: some View {
        return NavigationView {
            Color.red
        }.navigationTitle("Details")
    }
}
