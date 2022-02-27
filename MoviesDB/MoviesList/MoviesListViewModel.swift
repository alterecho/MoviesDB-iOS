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
//        Binding {
//            self?.searchText.wrappedValue ?? ""
//        } set: {
//            print("set \($0)")
//            self?.service.search($0) { result in
//                switch result {
//                case .success(let movies):
//                    break
//                case .failure(let error):
//                    break
//                }
//            }
//        }
//    }()
    let service = MoviesListViewService()
        
    @Published var moviesToDisplay: [Movie]?
    
    init() {
        searchBarPlaceholder = "searchBarPlaceholder"
        moviesToDisplay = []
        
        $searchText.debounce(for: .second(2), scheduler: DispatchQueue.main).sink { [weak self] searchString in
            self?.service.search(searchString) { result in
                switch result {
                case .success(let movies):
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }
}
