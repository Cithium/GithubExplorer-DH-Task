//
//  GithubRepositoryService.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

protocol GithubRepositoryService {
    func searchRepositories(query: String) async throws -> RepositorySearchResponse
    func repository(owner: String, name: String) async throws -> Repository
    func latestReleaseTag(owner: String, name: String) async throws -> String?
}

struct LiveGithubRepositoryService: GithubRepositoryService {
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func searchRepositories(query: String) async throws -> RepositorySearchResponse {
        try await client.send(
            GithubEndpoint.searchRepositories(query: query).request
        )
    }
    
    func repository(owner: String, name: String) async throws -> Repository {
        try await client.send(
            GithubEndpoint.repository(owner: owner, name: name).request
        )
    }
    
    func latestReleaseTag(owner: String, name: String) async throws -> String? {
        let response: Release = try await client.send(
            GithubEndpoint.latestRelease(owner: owner, name: name).request
        )
        return response.tagName
    }
}
