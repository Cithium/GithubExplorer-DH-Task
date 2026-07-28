//
//  RepositoryDetailViewModel.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-28.
//

import Foundation

@MainActor
@Observable
final class RepositoryDetailViewModel {
    
    enum ReleaseState: Equatable {
        case loading
        case version(String)
        case none
        case failed
    }

    let repository: Repository
    private(set) var release: ReleaseState = .loading

    private let service: GitHubRepositoryService

    init(
        repository: Repository,
        service: GitHubRepositoryService = LiveGitHubRepositoryService()
    ) {
        self.repository = repository
        self.service = service
    }

    func loadRelease() async {
        do {
            let tag = try await service.latestReleaseTag(
                owner: repository.owner.login,
                name: repository.name
            )
            release = tag.map(ReleaseState.version) ?? .none
        } catch is CancellationError {
            return
        } catch {
            release = .failed
        }
    }
}
