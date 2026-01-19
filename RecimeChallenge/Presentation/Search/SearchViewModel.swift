//
//  SearchViewModel.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/18/26.
//
import Combine
import Foundation
import Combine
import Foundation

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var searchText: String = ""
    @Published var selectedDietary: Set<String> = []
    @Published var excludeDietary: Bool = false
    @Published var selectedIngredients: Set<String> = []
    @Published var excludeIngredients: Bool = false
    @Published var selectedServing: Double = 0
    
    @Published var allIngredients: [String] = []
    @Published var allDietaryRestrictions: [String] = []


    private let useCase: RecipesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(useCase: RecipesUseCaseProtocol = RecipesUseCase()) {
        self.useCase = useCase
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.searchRecipes()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest3($selectedDietary, $selectedIngredients, $selectedServing)
            .sink { [weak self] _, _, _ in
                self?.searchRecipes()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($excludeDietary, $excludeIngredients)
            .sink { [weak self] _, _ in
                self?.searchRecipes()
            }
            .store(in: &cancellables)
        
    }
    
    deinit {
        
    }

    func searchRecipes() {
        isLoading = true
        Task {
            do {
                recipes = try await useCase.fetch(
                    searchText: searchText,
                    dietary: selectedDietary,
                    excludeDietary: excludeDietary,
                    ingredients: selectedIngredients,
                    excludeIngredients: excludeIngredients,
                    servings: selectedServing
                )
                allIngredients = await loadAllIngredients()
                allDietaryRestrictions = await loadAllDietaryRestrictions()
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func loadAllIngredients() async -> [String] {
        do {
            return try await useCase.allIngredients()
        } catch {
            errorMessage = error.localizedDescription
            return []
        }
    }
    
    func loadAllDietaryRestrictions() async -> [String] {
        do {
            return try await useCase.allDietaryRestrictions()
        } catch {
            errorMessage = error.localizedDescription
            return []
        }
    }
}

