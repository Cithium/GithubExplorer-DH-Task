//
//  RepositoryDetailView.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-28.
//

import SwiftUI

struct RepositoryDetailView: View {
    @State private var viewModel: RepositoryDetailViewModel

    init(repository: Repository) {
        _viewModel = State(wrappedValue: RepositoryDetailViewModel(repository: repository))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                metrics
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.loadRelease() }
    }

    private var header: some View {
        VStack(spacing: 8) {
            avatar

            Text(viewModel.repository.displayTitle)
                .font(.headline)
                .multilineTextAlignment(.center)

            if let language = viewModel.repository.language {
                Text(language)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
    
    private var avatar: some View {
        AsyncImage(url: viewModel.repository.owner.avatarURL) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                fallbackIcon
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(.rect(cornerRadius: 8))
        .accessibilityHidden(true)
    }
    
    private var fallbackIcon: some View {
        Image(systemName: "folder.fill")
    }

    private var metrics: some View {
        VStack(spacing: 8) {
            MetricRow(label: "Forks", value: viewModel.repository.forksCount.formatted(.number))
            
            paddedDivider
            
            MetricRow(label: "Issues", value: viewModel.repository.openIssuesCount.formatted(.number))
            
            paddedDivider
            
            MetricRow(label: "Starred by", value: viewModel.repository.stargazersCount.formatted(.number))
            
            paddedDivider
            
            MetricRow(label: "Last release version", value: releaseValue)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.separator, lineWidth: 0.5)
        )
    }
    
    private var paddedDivider: some View {
        Divider()
            .padding(.horizontal, 16)
    }

    private var releaseValue: String {
        switch viewModel.release {
        case .loading:  "Loading..."
        case .version(let tag): tag
        case .none:     "No releases"
        case .failed:   "Unavailable"
        }
    }
}

struct MetricRow: View {
    let label: String
    let value: String

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack {
                Text(label)
                Spacer(minLength: 16)
                Text(value).foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(label)
                Text(value).foregroundStyle(.secondary)
            }
        }
        .font(.subheadline)
        .accessibilityElement(children: .combine)
        .padding(8)
    }
}
