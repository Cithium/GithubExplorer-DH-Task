//
//  XCTestCase+MockData.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//

import XCTest

extension XCTestCase {
    func mockData(_ name: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        
        let url = try XCTUnwrap(
            bundle.url(forResource: name, withExtension: "json")
        )
        
        return try Data(contentsOf: url)
    }
}
