//
//  RepositorySearchResponse.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

import Foundation

nonisolated struct RepositorySearchResponse: Decodable, Equatable, Sendable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }
}
