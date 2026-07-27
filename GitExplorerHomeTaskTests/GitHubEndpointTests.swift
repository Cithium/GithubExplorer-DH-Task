//
//  GitHubEndpointTests.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//


import XCTest
@testable import GitExplorerHomeTask

final class GitHubEndpointTests: XCTestCase {
    func test_latestRelease_buildsPath() throws {
        let request = GitHubEndpoint.latestRelease(owner: "strapi", name: "strapi").request
        let url = try XCTUnwrap(request.url?.absoluteString)
        
        XCTAssertTrue(url.hasSuffix("/repos/strapi/strapi/releases/latest"))
    }
}
