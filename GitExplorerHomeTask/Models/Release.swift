//
//  Release.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

nonisolated struct Release: Decodable, Sendable, Equatable {
    let tagName: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
        case tagName = "tag_name"
    }
}
