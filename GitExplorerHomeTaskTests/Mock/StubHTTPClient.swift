//
//  StubHTTPClient.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

import Foundation
@testable import GitExplorerHomeTask

struct MockedHTTPClient: HTTPClient {
    enum Response {
        case success(Data)
        case failure(any Error)
    }

    let response: Response

    init(data: Data) { self.response = .success(data) }
    init(error: any Error) { self.response = .failure(error) }

    func send<T: Decodable & Sendable>(_ request: URLRequest) async throws -> T {
        switch response {
        case let .success(data):
            return try JSONDecoder().decode(T.self, from: data)
        case let .failure(error):
            throw error
        }
    }
}
