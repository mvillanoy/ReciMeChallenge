//
//  HomeView.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/17/26.
//

import SwiftUI

struct HomeView: View {
    @Namespace var namespace

    @StateObject private var viewModel = HomeViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {

        NavigationStack {
            ScrollView {
                Text("What can you make today?")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.top, 32)

                NavigationLink {
                    SearchView()
                        .toolbarVisibility(.hidden, for: .navigationBar)
                        .navigationTransition(
                            .zoom(sourceID: "search", in: namespace)
                        )
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)

                        Text("Search Recipes")
                            .foregroundColor(.secondary)

                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding()
                    .matchedTransitionSource(id: "search", in: namespace)
                }

                LazyVGrid(columns: columns, spacing: 0) {
                    if viewModel.isLoading {
                            ForEach(0..<6, id: \.self) { _ in
                                ShimmerRecipeItem()
                            }
                    } else {
                        
                        ForEach(viewModel.results, id: \.id) { recipe in
                            NavigationLink {
                                RecipeView(recipe: recipe)
                                    .toolbarVisibility(.hidden, for: .navigationBar)
                                    .navigationTransition(
                                        .zoom(sourceID: recipe.id, in: namespace)
                                    )
                            } label: {
                                RecipeItem(recipe: recipe)
                                    .contentShape(Rectangle())
                                    .matchedTransitionSource(
                                        id: recipe.id,
                                        in: namespace
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.loadRecipes()
        }
    }

}

#Preview {
    HomeView()
}
