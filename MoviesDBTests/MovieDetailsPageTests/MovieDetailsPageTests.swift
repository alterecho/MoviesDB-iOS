//
//  MovieDetailsPageTests.swift
//  MoviesDBTests
//
//  Created by Vijaychandran Jayachandran on 3/3/22.
//

import XCTest
@testable import MoviesDB

class MovieDetailsPageTests<ViewModel: MovieDetailsViewModelProtocol>: XCTestCase {
    var mockService: MockDetailsViewService?
    var viewModel: ViewModel?
    
    override func setUpWithError() throws {
        let mockService = MockDetailsViewService()
        
        viewModel = MovieDetailsViewModel(imdbID: "") as? ViewModel
        viewModel?.service = mockService
        
        
        self.mockService = mockService
        
        try super.setUpWithError()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testDetailsFetchedOnLoad() {
        viewModel?.onAppear()
        XCTAssert(mockService?.fetchMovieDetailsCalled ?? false)
    }
}
