//
//  MoviesListProtocol.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 3/3/22.
//

import Foundation

protocol MoviesListViewModelProtocol: ObservableObject {
    
    var service: MoviesListViewServiceProtocol { get set }
    
    var pageTitle: String { get }
    var searchBarPlaceholder: String { get }
    var searchText: String { get set }
    var moviesToDisplay: [Movie] { get set }
    var alert: AlertModel { get set }
    var isLoading: Bool { get }
    var searchHeader: String { get }
    
    func movieCellDidAppear(index: Int)
}

protocol MoviesListViewServiceProtocol {
    func search(_ searchString: String, page: Int, completionHandler: @escaping (Result<SearchResponse, Error>) -> Void)
}

