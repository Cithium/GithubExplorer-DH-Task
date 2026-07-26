//
//  GitHubError.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

enum GitHubError: Error, Equatable {
    case notFound
    case unauthorized
    case unexpectedStatus(Int)
    case transport
    case decoding
}
