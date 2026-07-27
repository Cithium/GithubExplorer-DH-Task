//
//  Repository.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

import Foundation

nonisolated struct Repository: Decodable, Sendable, Equatable, Identifiable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let description: String?
    let language: String?
    let forksCount: Int
    let openIssuesCount: Int
    let stargazersCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, owner, description, language
        case fullName = "full_name"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case stargazersCount = "stargazers_count"
    }
}

extension Repository {
    nonisolated struct Owner: Decodable, Sendable, Equatable {
        let login: String
        private let avatarURLString: String?

        var avatarURL: URL? {
            avatarURLString.flatMap(URL.init(string:))
        }

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURLString = "avatar_url"
        }
    }

    var displayTitle: String { "\(owner.login) / \(name)" }
}
