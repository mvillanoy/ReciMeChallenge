import Kingfisher
//
//  RecipeView.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/17/26.
//
import SwiftUI

struct RecipeView: View {
    @StateObject private var viewModel: RecipeViewModel
    @Environment(\.dismiss) private var dismiss

    init(recipe: Recipe) {
        _viewModel = StateObject(
            wrappedValue: RecipeViewModel(recipe: recipe)
        )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ScrollView(showsIndicators: false) {
                    KFImage(URL(string: viewModel.recipe.image ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: 320)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text(viewModel.recipe.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 16) {
                            InfoCard(
                                icon: "clock",
                                title: "Prep Time",
                                value: "\(viewModel.recipe.prepTimeMinutes) MIN",
                                color: .green
                            )
                            InfoCard(
                                icon: "flame",
                                title: "Cook Time",
                                value: "\(viewModel.recipe.cookingTimeMinutes) MIN",
                                color: .orange
                            )
                            InfoCard(
                                icon: "fork.knife.circle",
                                title: "Servings",
                                value: "\(viewModel.servings)",
                                color: .blue
                            )
                        }
                        
                        HStack {
                            Text("Serving Size")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            
                            Stepper(value: $viewModel.servings, in: 1...12) {
                                Text("\(viewModel.servings)")
                                    .fontWeight(.semibold)
                            }
                            .labelsHidden()
                        }
                        
                        Text("Ingredients")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Picker("Units", selection: $viewModel.measurementSystem) {
                            ForEach(MeasurementSystem.allCases) { system in
                                Text(system.rawValue).tag(system)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.recipe.ingredients, id: \.id) {
                                ingredient in
                                IngredientItem(
                                    ingredient: ingredient,
                                    baseServings: viewModel.recipe.baseServings,
                                    measurementSystem: $viewModel.measurementSystem,
                                    currentServings: $viewModel.servings
                                )
                            }
                        }
                        
                        Text("Directions")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 16) {
                            ForEach(
                                viewModel.recipe.cookingInstructions.indices,
                                id: \.self
                            ) { index in
                                HStack(alignment: .top, spacing: 12) {
                                    Text("\(index + 1)")
                                        .font(.headline)
                                        .foregroundColor(.green)
                                        .frame(width: 24)
                                    
                                    Text(
                                        viewModel.recipe.cookingInstructions[index]
                                    )
                                    .font(.body)
                                    Spacer()
                                    
                                }
                            }
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding(16)
                }
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                }
                .glassEffect()
                .padding(.top, 50)
                .padding(.leading, 16)
                
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    RecipeView(recipe: sampleRecipe)
}
