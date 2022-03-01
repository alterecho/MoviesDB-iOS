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
                TextField(viewModel.searchBarPlaceholder, text: $viewModel.searchText).padding()
                let screenSize = UIScreen.main.bounds
                let numberOfItemsPerRow = 3
                let spacing = 5.0
                let cellSize = CGSize(width: screenSize.width / CGFloat(numberOfItemsPerRow),
                                      height: screenSize.height / CGFloat(numberOfItemsPerRow))
                let gridItem = GridItem(.fixed(cellSize.width), spacing: spacing)
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: [gridItem, gridItem, gridItem], alignment: .center, spacing: spacing, pinnedViews: [.sectionHeaders]) {
                            Section(header: Text("Results").frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white)) {
                                ForEach(viewModel.moviesToDisplay.indices, id: \.self) { index in
                                    let movie = viewModel.moviesToDisplay[index]
                                    if let imdbID = movie.imdbID {
                                        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(imdbID: imdbID))) {
                                            MovieGridCellView(movie: viewModel.moviesToDisplay[index], size: cellSize).onAppear {
                                                viewModel.movieCellDidAppear(index: Int(index.magnitude))
                                            }
                                        }
                                    } else {
                                        MovieGridCellView(movie: viewModel.moviesToDisplay[index], size: cellSize).onAppear {
                                            viewModel.movieCellDidAppear(index: Int(index.magnitude))
                                        }
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
                  dismissButton: .default(Text(viewModel.alert.buttonTitle ?? "")))
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

