//
//  SearchView.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//


import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Repository Library")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.query,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search for repository")
            .task(id: viewModel.query) {
                await viewModel.search()
            }
        
    }

    @ViewBuilder
    private var content: some View {
        ZStack {
            switch viewModel.state {
            case .idle:
                emptyState
            case .loading:
                ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
            case let .loaded(repositories, totalCount):
                resultsList(repositories, totalCount: totalCount)
            case .noMatches:
                message(title: "No results", detail: "Try something different")
            case let .failed(error):
                failureState(error)
            }
        }
    }

    private func resultsList(_ repositories: [Repository], totalCount: Int) -> some View {
        List {
            Section {
                ForEach(repositories) { repository in
                    Button {
                        print("Navigate to Detail")
                    } label: {
                        RepositoryRow(repository: repository)
                    }
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                }
            } header: {
                Text("\(totalCount) results")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .listStyle(.plain)
    }
    
    private var noMatches: some View {
        VStack(spacing: 16) {
            Image("folderIcon")
                .accessibilityHidden(true)
            
            message(title: "No results", detail: "Try something different")
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image("folderIcon")
                .accessibilityHidden(true)
            
            message(title: "A little empty", detail: "Search for a repository and save it as favourite"
            )
        }
    }

    private func failureState(_ error: GitHubError) -> some View {
        VStack(spacing: 12) {
            message(title: "Something went wrong", detail: errorDetail(for: error))
            Button("Try again") {
                Task { await viewModel.retry() }
            }
        }
    }

    private func errorDetail(for error: GitHubError) -> String {
        switch error {
        case .transport:
            "Check your connection and try again."
        default:
            "Please try again."
        }
    }

    private func message(title: String, detail: String) -> some View {
        VStack(spacing: 8) {
            Text(title).font(.subheadline.weight(.semibold))
            Text(detail)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
    }
}
