//
//  RecipeUseCase.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/18/26.
//

import Foundation

protocol RecipesUseCaseProtocol {
    func fetch(
        searchText: String,
        dietary: Set<String>,
        excludeDietary: Bool,
        ingredients: Set<String>,
        excludeIngredients: Bool,
        servings: Double
    ) async throws -> [Recipe]

    func allIngredients() async throws -> [String]
    func allDietaryRestrictions() async throws -> [String]
    func fetch() async throws -> [Recipe]
}

final class RecipesUseCase: RecipesUseCaseProtocol {
    private let repository: RecipeRepositoryProtocol

    init(repository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.repository = repository
    }

    func fetch(
        searchText: String = "",
        dietary: Set<String> = [],
        excludeDietary: Bool = false,
        ingredients: Set<String> = [],
        excludeIngredients: Bool = false,
        servings: Double = 0
    ) async throws -> [Recipe] {
        let recipes = try await repository.fetchRecipes()

        return recipes.filter { recipe in
            let matchesSearch =
                searchText.isEmpty
                || recipe.title.localizedCaseInsensitiveContains(searchText)
                || recipe.cookingInstructions.contains { instruction in
                    instruction.localizedCaseInsensitiveContains(searchText)
                }

            let recipeDietary = Set(recipe.dietaryAttributes.map { $0.lowercased() })
            let matchesDietary: Bool
            if dietary.isEmpty {
                matchesDietary = true
            } else if excludeDietary {
                matchesDietary = dietary.isDisjoint(with: recipeDietary)
            } else {
                matchesDietary = !dietary.isDisjoint(with: recipeDietary)
            }

            let recipeIngredients = Set(recipe.ingredients.map { $0.name.lowercased() })
            let matchesIngredients: Bool
            if ingredients.isEmpty {
                matchesIngredients = true
            } else if excludeIngredients {
                matchesIngredients = ingredients.isDisjoint(with: recipeIngredients)
            } else {
                matchesIngredients = !ingredients.isDisjoint(with: recipeIngredients)
            }

            let matchesServings =
                servings == 0 || recipe.baseServings == Int(servings)

            return matchesSearch && matchesDietary && matchesIngredients && matchesServings
        }
    }


    func fetch() async throws -> [Recipe] {
        try await fetch(
            searchText: "",
            dietary: [],
            ingredients: [],
            servings: 0
        )
    }

    func allIngredients() async throws -> [String] {
        let recipes = try await repository.fetchRecipes()
        let ingredients = recipes.flatMap { $0.ingredients.map { $0.name } }
        return Array(Set(ingredients)).sorted()
    }

    func allDietaryRestrictions() async throws -> [String] {
        let recipes = try await repository.fetchRecipes()
        let restrictions = recipes.flatMap { $0.dietaryAttributes.map { $0 } }
        return Array(Set(restrictions)).sorted()
    }
}
