//
//  MoviesListViewModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import SwiftUI
import Combine

protocol MoviesListViewModelProtocol: ObservableObject {
    var pageTitle: String { get }
    var searchBarPlaceholder: String { get }
    var searchText: String { get set }
    var moviesToDisplay: [Movie] { get set }
    var alert: AlertModel { get set }
    var isLoading: Bool { get }
}

class MoviesListViewModel: MoviesListViewModelProtocol {
    var pageTitle = "Film list"
    var searchBarPlaceholder: String
    
    @Published var searchText: String
    @Published var moviesToDisplay: [Movie]
    @Published var alert = AlertModel()
    @Published var isLoading = false
    
    private let service = MoviesListViewService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        searchBarPlaceholder = "searchBarPlaceholder"
        searchText = ""
        moviesToDisplay = []
        
        $searchText.debounce(for: .seconds(2), scheduler: RunLoop.main).sink { [weak self] searchString in
            self?.performSearch(searchString: searchString)
        }.store(in: &cancellables)
        
    }
    
    private func performSearch(searchString: String) {
        isLoading = true
        service.search("marvel") { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let movies):
                self?.moviesToDisplay = movies
            case .failure(let error):
                self?.alert = AlertModel(error: error)
                break
            }
        }
    }
    
}
