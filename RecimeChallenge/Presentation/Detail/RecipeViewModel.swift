//
//  RecipeViewModel.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/17/26.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {

    @Published var recipe: Recipe
    @Published var measurementSystem: MeasurementSystem = .metric
    @Published var servings: Int = 1

    init(recipe: Recipe) {
        self.recipe = recipe
        self.servings = recipe.baseServings
    }

}
