//
//  MoviesListViewModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import SwiftUI
import Combine

protocol MoviesListViewModelProtocol: ObservableObject {
    var searchBarPlaceholder: String { get }
    var searchText: Binding<String> { get }
    var moviesToDisplay: [Movie]? { get }
    
}

class MoviesListViewModel: MoviesListViewModelProtocol {
    @Published var searchBarPlaceholder: String
    
    lazy var searchText: Binding<String> = { [weak self] in
        Binding {
            self?.searchText.wrappedValue ?? ""
        } set: {
            print("set \($0)")
            self?.service.search($0) { result in
                switch result {
                case .success(let movies):
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }()
    
    let service = MoviesListViewService()
        
    @Published var moviesToDisplay: [Movie]?
    
    init() {
        searchBarPlaceholder = "searchBarPlaceholder"
        moviesToDisplay = []
    }
}
