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
                let cellWidth = screenSize.width / 3.0 - 2.0
                let gridItem = GridItem(.fixed(cellWidth), spacing: 0.0)
                ScrollView {
                    LazyVGrid(columns: [gridItem, gridItem, gridItem], alignment: .center, spacing: nil, pinnedViews: [.sectionHeaders]) {
                        Section(header: Text("Results").frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white)) {
                            ForEach(viewModel.moviesToDisplay.indices, id: \.self) { index in
                                MovieGridCellView(movie: viewModel.moviesToDisplay[index])
                            }
                        }
                    }
                }
            }
            
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

