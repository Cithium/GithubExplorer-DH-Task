//
//  SearchViewModelTests.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-28.
//

import XCTest
@testable import GitExplorerHomeTask

@MainActor
final class SearchViewModelTests: XCTestCase {

    func test_AC2_2_queryBelowThreeCharactersStaysIdle() async {
        let viewModel = SearchViewModel(service: MockedRepositoryService())
        viewModel.query = "st"
        
        await viewModel.search()
        
        XCTAssertEqual(viewModel.state, .idle)
    }
}
