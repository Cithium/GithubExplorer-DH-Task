//
//  RepositoryRow.swift
//  GitExplorerHomeTask
//
//  Created by Hamza Abdulilah on 2026-07-27.
//


import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            avatar
            VStack(alignment: .leading, spacing: 8) {
                Text(repository.displayTitle)
                    .font(.subheadline.weight(.semibold))

                if let description = repository.description {
                    Text(description)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            Spacer()
        }
        .accessibilityElement(children: .combine)
    }

    private var avatar: some View {
        AsyncImage(url: repository.owner.avatarURL) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                fallbackIcon
            }
        }
        .frame(width: 42, height: 42)
        .clipShape(.rect(cornerRadius: 8))
        .accessibilityHidden(true)
    }

    private var fallbackIcon: some View {
        Image(systemName: "folder.fill")
    }
}
