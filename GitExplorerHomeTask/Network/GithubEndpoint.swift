//
//  GithubEndpoint.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

import Foundation

enum GithubEndpoint {
    case searchRepositories(query: String)
    case repository(owner: String, name: String)
    case latestRelease(owner: String, name: String)
    
    private static let baseURL = URL(string: "https://api.github.com")!
    
    var request: URLRequest {
        var components = URLComponents(
            url: Self.baseURL.appending(path: path),
            resolvingAgainstBaseURL: false
        )!

        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        return request
    }
    
    private var path: String {
        switch self {
        case .searchRepositories:
            "search/repositories"
        case let .repository(owner, name):
            "repos/\(owner)/\(name)"
        case let .latestRelease(owner, name):
            "repos/\(owner)/\(name)/releases/latest"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case let .searchRepositories(query):
            [
                URLQueryItem(name: "q", value: query)
            ]
        default:
            nil
        }
    }
}
