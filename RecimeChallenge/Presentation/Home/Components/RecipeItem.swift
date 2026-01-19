//
//  RecipeItem.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/17/26.
//

import SwiftUI
import Kingfisher
import Shimmer


struct RecipeItem: View {
    let recipe: Recipe
    let itemHeight: CGFloat = 300

    var body: some View {
        GeometryReader { geometry in
            let itemWidth = geometry.size.width
            VStack(alignment: .center, spacing: 8) {
                KFImage(URL(string: recipe.image ?? ""))
                    .placeholder {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray5))
                            .frame(width: itemWidth - 32, height: 160)
                            .modifier(Shimmer())
                        
                    }
                    .fade(duration: 0.2)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: itemWidth - 32, height: 160)
                    .clipped()
                    .cornerRadius(16)
                
                
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .frame(height: UIFont.preferredFont(forTextStyle: .headline).lineHeight * 2.5)
                
                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image(systemName: "clock")
                        Text("\(recipe.prepTimeMinutes) min")
                    }
                    
                    HStack(spacing: 2) {
                        Image(systemName: "flame")
                        Text("\(recipe.cookingTimeMinutes) min")
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                
            }
            .padding()
            .frame(width: itemWidth)
            .background(
                Color(.systemBackground)
                    .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 4)
            )
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 4)
            .padding(.vertical, 4)
        }
        .frame(height: itemHeight)
        
    }
}

#Preview {
    RecipeItem(recipe: sampleRecipe)
        .padding()
}
