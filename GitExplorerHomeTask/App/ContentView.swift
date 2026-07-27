//
//  ContentView.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                let service = LiveGithubRepositoryService()
                
                let result = try await service.searchRepositories(query: "strapi")
                print(result.totalCount, result.items.first?.fullName ?? "-")
                
                let tag = try await service.latestReleaseTag(owner: "strapi", name: "strapi")
                print(tag ?? "no release")
            }
        }
    }
}

#Preview {
    ContentView()
}
