//
//  HomeViewModel.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/17/26.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var results: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var totalResults: Int = 0
    @Published var errorMessage: String?

    private let recipesUseCase: RecipesUseCaseProtocol

    init(fetchRecipesUseCase: RecipesUseCaseProtocol = RecipesUseCase()) {
        self.recipesUseCase = fetchRecipesUseCase
    }

       func loadRecipes() {
           isLoading = true

           Task {
               do {
                   results = try await recipesUseCase.fetch()
               } catch {
                   errorMessage = error.localizedDescription
               }
               isLoading = false
           }
       }
}
