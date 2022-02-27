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
    var searchText: String { get set }
    var moviesToDisplay: [Movie]? { get }
    
}

class MoviesListViewModel: MoviesListViewModelProtocol {
    @Published var searchBarPlaceholder: String
    @Published var searchText: String = ""
    @Published var moviesToDisplay: [Movie]?
    
    private let service = MoviesListViewService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        searchBarPlaceholder = "searchBarPlaceholder"
        moviesToDisplay = []
        
        $searchText.debounce(for: .seconds(2), scheduler: RunLoop.main).sink { [weak self] searchString in
            self?.service.search(searchString) { result in
                switch result {
                case .success(let movies):
                    break
                case .failure(let error):
                    break
                }
            }
        }.store(in: &cancellables)
    }
}
