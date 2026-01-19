//
//  RecipeRepository.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/18/26.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

final class RecipeRepository: RecipeRepositoryProtocol {
    func fetchRecipes() async throws -> [Recipe] {

        guard
            let url = Bundle.main.url(
                forResource: "recipe",
                withExtension: "json"
            )
        else {
            throw NSError(
                domain: "RecipeRepository",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "recipes.json not found"]
            )
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let recipes = try decoder.decode([Recipe].self, from: data)
        return recipes
    }
}
