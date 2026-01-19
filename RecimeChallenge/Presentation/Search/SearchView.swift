//
//  SearchView.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/18/26.
//

import SwiftUI

struct SearchView: View {
    @Namespace var namespace
    @StateObject private var viewModel = SearchViewModel()

    @Environment(\.dismiss) private var dismiss

    @State private var showDietarySheet = false
    @State private var showIngredientsSheet = false
    @State private var showServingSheet = false

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    var body: some View {
        NavigationStack {
            ScrollView {

                HStack {

                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .glassEffect()
                    .padding(.leading, 16)

                    Spacer()

                }

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)

                    TextField("Search recipes", text: $viewModel.searchText)
                        .textFieldStyle(.plain)

                    if !viewModel.searchText.isEmpty {
                        Button {
                            viewModel.searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)

                HStack(spacing: 12) {

                    FilterPill(
                        title: "Dietary",
                        selectedValues: Array(viewModel.selectedDietary),
                        accentColor: .greenAccent,
                        onTap: {
                            showDietarySheet.toggle()
                        }
                    )
                    .sheet(isPresented: $showDietarySheet) {
                        FilterSheet(
                            title: "Dietary Attributes",
                            options: viewModel.allDietaryRestrictions,
                            accentColor: .greenAccent,
                            selectedOptions: $viewModel.selectedDietary, isExclude: $viewModel.excludeDietary
                        )
                    }

                    FilterPill(
                        title: "Ingredients",
                        selectedValues: Array(viewModel.selectedIngredients),
                        accentColor: .orangeAccent,
                        onTap: {
                            showIngredientsSheet.toggle()
                        }
                    )
                    .sheet(isPresented: $showIngredientsSheet) {
                        FilterSheet(
                            title: "Ingredients",
                            options: viewModel.allIngredients,
                            accentColor: .orangeAccent,
                            selectedOptions: $viewModel.selectedIngredients, isExclude: $viewModel.excludeIngredients
                        )
                    }

                    FilterPill(
                        title: "Serving Size",
                        selectedValues: viewModel.selectedServing == 0
                            ? []
                            : [
                                "Serving Size: \(Int(viewModel.selectedServing))"
                            ],
                        accentColor: .blueAccent,
                        onTap: {
                            showServingSheet.toggle()
                        }
                    )
                    .sheet(isPresented: $showServingSheet) {
                        RangeSheet(
                            selectedServing: $viewModel.selectedServing,
                            title: "Serving Size",
                            subtitle: "Select Serving Size",
                            range: 1...10,
                            accentColor: .blueAccent
                        )
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                if viewModel.recipes.isEmpty {
                    VStack {
                        Spacer()
                        Text("No recipes found")
                            .font(.title3)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 60)

                } else {
                    
                    LazyVGrid(columns: columns, spacing: 0) {
                        
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            NavigationLink {
                                RecipeView(recipe: recipe)
                                    .toolbarVisibility(
                                        .hidden,
                                        for: .navigationBar
                                    )
                                    .navigationTransition(
                                        .zoom(
                                            sourceID: recipe.id,
                                            in: namespace
                                        )
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
                    .padding(.horizontal)
                }

            }
            .onAppear {
                viewModel.searchRecipes()
            }
        }
    }

}

#Preview {
    SearchView()
}
