//
//  FilterPill.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/19/26.
//

import SwiftUI

struct FilterPill: View {
    let title: String
    let selectedValues: [String]
    let accentColor: Color
    let onTap: () -> Void

    private var isActive: Bool {
        !selectedValues.isEmpty
    }

    private var displayText: String {
        guard !selectedValues.isEmpty else { return title.capitalized }

        let capitalizedValues = selectedValues.map { $0.capitalized }

        if capitalizedValues.count <= 2 {
            return capitalizedValues.joined(separator: ", ")
        } else {
            let firstTwo = capitalizedValues.prefix(2).joined(separator: ", ")
            return "\(firstTwo) +\(capitalizedValues.count - 2)"
        }
    }


    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Text(displayText)
                    .font(.caption)
                    .lineLimit(1)

                Image(systemName: "chevron.down")
                    .font(.caption)
            }
            .foregroundColor(isActive ? accentColor : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Group {
                    if isActive {
                        accentColor.opacity(0.15)
                    } else {
                        Color.clear
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        isActive ? accentColor : Color.secondary.opacity(0.4),
                        lineWidth: 1
                    )
            )
            .cornerRadius(20)
        }
    }
}

