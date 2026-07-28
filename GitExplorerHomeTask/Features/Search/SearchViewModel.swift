//
//  SearchViewModel.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

import Foundation

@MainActor @Observable
final class SearchViewModel {

    enum SearchState: Equatable {
        case idle
        case loading
        case loaded([Repository], totalCount: Int)
        case noMatches
        case failed(GitHubError)
    }
    
    private enum Constants {
        static let minimumSearchCharacters: Int = 3
        static let debounce: Duration = .milliseconds(300)
    }
    
    var query: String = ""
    private var lastSearched: String?
    var state: SearchState = .idle
    
    private let service : GitHubRepositoryService
    
    init(service: GitHubRepositoryService = LiveGitHubRepositoryService()) {
        self.service = service
    }
    
    func search() async {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedQuery.count >= Constants.minimumSearchCharacters else {
            if case .loaded(_, _) = state {
                return
            }
            state = .idle
            return
        }
        
        if trimmedQuery == lastSearched {
            return
        }
        
        do {
            try await Task.sleep(for: Constants.debounce)
        } catch {
            return
        }
        
        state = .loading
        
        do {
            let result = try await service.searchRepositories(query: trimmedQuery)
            state = result.items.isEmpty ? .noMatches : .loaded(result.items, totalCount: result.totalCount)
            lastSearched = trimmedQuery
        } catch _ as CancellationError  {
            return
        } catch let error as GitHubError {
            state = .failed(error)
        } catch {
            state = .failed(.transport)
        }
    }
    
    func retry() async {
        await search()
    }
}

