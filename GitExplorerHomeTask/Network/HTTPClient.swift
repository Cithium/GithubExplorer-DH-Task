//
//  HTTPClient.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

import Foundation

protocol HTTPClient {
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
}

nonisolated struct URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError where error.code == .cancelled {
            throw CancellationError()
        } catch {
            throw GitHubError.transport
        }
        
        guard let http = response as? HTTPURLResponse else {
            throw GitHubError.transport
        }
        
        try Self.validate(http)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw GitHubError.decoding
        }
    }
    
    private static func validate(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200..<300:
            return
        case 401:
            throw GitHubError.unauthorized
        case 404:
            throw GitHubError.notFound
        default:
            throw GitHubError.unexpectedStatus(response.statusCode)
        }
    }
}
