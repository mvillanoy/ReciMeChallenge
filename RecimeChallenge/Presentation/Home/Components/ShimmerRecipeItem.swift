//
//  ShimmerRecipeItem.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/19/26.
//

import Shimmer
import SwiftUI

struct ShimmerRecipeItem: View {
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray5))
                .frame(height: 160)

            VStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(height: 14)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(height: 14)
                    .padding(.trailing, 24)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 4, y: 4)
        .modifier(Shimmer())
    }
}
