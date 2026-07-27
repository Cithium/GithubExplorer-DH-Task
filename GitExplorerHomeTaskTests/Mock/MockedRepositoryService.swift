//
//  MockedRepositoryService.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-28.
//


import Foundation
@testable import GitExplorerHomeTask

struct MockedRepositoryService: GitHubRepositoryService {
    var searchResult: Result<RepositorySearchResponse, any Error> = .success(.empty)

    func searchRepositories(query: String) async throws -> RepositorySearchResponse {
        try searchResult.get()
    }
    
    func latestReleaseTag(owner: String, name: String) async throws -> String? {
        ""
    }
}

extension RepositorySearchResponse {
    static let empty = RepositorySearchResponse(
        totalCount: 0,
        incompleteResults: false,
        items: []
    )
}
