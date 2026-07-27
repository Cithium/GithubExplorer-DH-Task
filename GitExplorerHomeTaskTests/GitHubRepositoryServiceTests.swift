//
//  GitHubRepositoryServiceTests.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//


import XCTest
@testable import GitExplorerHomeTask

final class GitHubRepositoryServiceTests: XCTestCase {
    
    func test_searchResponseDecodeAndTotalCount() async throws {
        let client = MockedHTTPClient(data: try mockData("search_repositories"))
        let service = LiveGithubRepositoryService(client: client)
        
        let result = try await service.searchRepositories(query: "Tetris")
        let count = result.items.count
        let totalCount = result.totalCount
        
        XCTAssertEqual(count, 1)
        XCTAssertEqual(totalCount, 40)
    }
}

// More tests here could be like testing avatar url, nullable values (repository that has no releases) etc

