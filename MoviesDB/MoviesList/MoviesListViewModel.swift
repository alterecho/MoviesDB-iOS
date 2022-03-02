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
    var searchHeader: String { get }
    
    func movieCellDidAppear(index: Int)
}

class MoviesListViewModel: MoviesListViewModelProtocol {
    
    private static let pageStartIndex = 1
    
    var searchBarPlaceholder: String
    
    @Published var searchText: String
    @Published var moviesToDisplay: [Movie]
    @Published var alert = AlertModel()
    @Published var isLoading = false
    @Published var pageTitle = "Film list"
    var searchHeader = ""

    
    private let service = MoviesListViewService()
    private var cancellables = Set<AnyCancellable>()
    
    private var totalResults: Int?
    private var currentPage = MoviesListViewModel.pageStartIndex
    private var currentSearchString: String?
    private var currentPageToFetch: Int?

    init() {
        searchBarPlaceholder = "Type movie, series, episode here"
        searchText = ""
        moviesToDisplay = []
        
        $searchText.debounce(for: .seconds(2), scheduler: RunLoop.main).sink { [weak self] searchString in
            self?.performSearch(searchString: searchString, page: MoviesListViewModel.pageStartIndex)
        }.store(in: &cancellables)
    }
    
    private func performSearch(searchString: String, page: Int) {
        if searchString == currentSearchString &&  page == currentPageToFetch {
            return
        } else if searchString != currentSearchString {
            currentSearchString = searchString
        }
        
        
        currentPageToFetch = page
        
        isLoading = true
        service.search(searchString, page: page) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                let movies = response.search?.map { response in
                    return Movie(response: response)
                } ?? []
                self?.currentPage += 1
                self?.currentPageToFetch = nil
                self?.totalResults = Int(response.totalResults ?? "")
                if searchString.isEmpty {
                    self?.searchHeader = ""
                } else {
                    self?.searchHeader = "Results for \(searchString)"
                }
                
                if searchString == self?.currentSearchString {
                    self?.moviesToDisplay.append(contentsOf: movies)
                } else {
                    self?.moviesToDisplay = movies
                }

            case .failure(let error):
                self?.alert = AlertModel(error: error)
                break
            }
        }
    }
    
    func movieCellDidAppear(index: Int) {
        guard let totalResults = totalResults else {
            return
        }

        if index == (totalResults - 2) {
            return
        }
        loadNextPage()
    }
    
    private func loadNextPage() {
        guard let currentSearchString = currentSearchString else {
            return
        }

        performSearch(searchString: currentSearchString, page: currentPage + 1)
        
    }
}
