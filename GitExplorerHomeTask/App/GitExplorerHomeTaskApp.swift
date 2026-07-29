//
//  GitExplorerHomeTaskApp.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-26.
//

import SwiftUI

@main
struct GitExplorerHomeTaskApp: App {
    @State private var path = NavigationPath()

    var body: some Scene {
        WindowGroup {
            SearchView(path: $path)
        }
    }
}
