//
//  MoviesListScreen.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import SwiftUI

struct MoviesListView<ViewModel: MoviesListViewModelProtocol>: View {
    @State var vm: ViewModel?
    var body: some View {
        NavigationView {
            if let searchText = vm?.searchText {
                TextField(vm?.searchBarPlaceholder ?? "", text: searchText)
            }
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(vm: MoviesListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

