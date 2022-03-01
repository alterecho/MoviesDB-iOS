//
//  MoviesListScreen.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import SwiftUI

struct MoviesListView<ViewModel: MoviesListViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 2.0) {
                TextField(viewModel.searchBarPlaceholder, text: $viewModel.searchText)
                let screenSize = UIScreen.main.bounds
                let cellSize = CGSize(width: screenSize.width / 3.0 - 2.0, height: screenSize.height / 3.0)
                let gridItem = GridItem(.fixed(cellSize.width), spacing: 0.0)
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: [gridItem, gridItem, gridItem], alignment: .center, spacing: nil, pinnedViews: [.sectionHeaders]) {
                            Section(header: Text("Results").frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white)) {
                                ForEach(viewModel.moviesToDisplay.indices, id: \.self) { index in
                                    let movie = viewModel.moviesToDisplay[index]
                                    if let imdbID = movie.imdbID {
                                        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(imdbID: imdbID))) {
                                            MovieGridCellView(movie: viewModel.moviesToDisplay[index], size: cellSize)
                                        }
                                    } else {
                                        MovieGridCellView(movie: viewModel.moviesToDisplay[index], size: cellSize)
                                    }
                                }
                            }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black.opacity(0.25))
                    }
                }
            }.navigationTitle(viewModel.pageTitle)
        }.alert(isPresented: $viewModel.alert.isShowing) {
            Alert(title: Text(viewModel.alert.title ?? ""), message: Text(viewModel.alert.message ?? ""),
                  dismissButton: .default(Text(viewModel.alert.buttonTitle ?? "")) {
                
            })
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

