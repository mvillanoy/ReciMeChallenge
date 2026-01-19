//
//  Recipe.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/16/26.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let title: String
    let description: String
    let image: String?
    let baseServings: Int
    let numberOfServings: Int
    let prepTimeMinutes: Int
    let cookingTimeMinutes: Int
    let ingredients: [Ingredient]
    let cookingInstructions: [String]
    let dietaryAttributes: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case image
        case baseServings = "base_servings"
        case numberOfServings = "number_of_servings"
        case prepTimeMinutes = "prep_time_minutes"
        case cookingTimeMinutes = "cooking_time_minutes"
        case ingredients
        case cookingInstructions = "cooking_instructions"
        case dietaryAttributes = "dietary_attributes"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(
            String.self,
            forKey: .description
        )
        self.image = try container.decodeIfPresent(String.self, forKey: .image)

        self.baseServings = try container.decode(
            Int.self,
            forKey: .baseServings
        )
        self.numberOfServings = try container.decode(
            Int.self,
            forKey: .numberOfServings
        )

        self.prepTimeMinutes = try container.decode(
            Int.self,
            forKey: .prepTimeMinutes
        )
        self.cookingTimeMinutes = try container.decode(
            Int.self,
            forKey: .cookingTimeMinutes
        )

        self.ingredients = try container.decode(
            [Ingredient].self,
            forKey: .ingredients
        )
        self.cookingInstructions = try container.decode(
            [String].self,
            forKey: .cookingInstructions
        )
        self.dietaryAttributes = try container.decode(
            [String].self,
            forKey: .dietaryAttributes
        )
    }

    init(
        id: Int,
        title: String,
        description: String,
        image: String? = nil,
        baseServings: Int,
        numberOfServings: Int,
        prepTimeMinutes: Int,
        cookingTimeMinutes: Int,
        ingredients: [Ingredient],
        cookingInstructions: [String],
        dietaryAttributes: [String] = []
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.baseServings = baseServings
        self.numberOfServings = numberOfServings
        self.prepTimeMinutes = prepTimeMinutes
        self.cookingTimeMinutes = cookingTimeMinutes
        self.ingredients = ingredients
        self.cookingInstructions = cookingInstructions
        self.dietaryAttributes = dietaryAttributes
    }

}

let sampleRecipe = Recipe(
    id: 1,
    title: "Vegetable Stir-Fry",
    description:
        "A quick and colorful vegetable stir-fry with a savory soy-garlic sauce.",
    image:
        "https://cdn.loveandlemons.com/wp-content/uploads/2025/02/stir-fry-1160x1711.jpg",
    baseServings: 2,
    numberOfServings: 2,
    prepTimeMinutes: 10,
    cookingTimeMinutes: 8,
    ingredients: [
        Ingredient(
            id: 1,
            name: "Vegetable Oil",
            quantity: Quantity(
                base: 15,
                metric: Unit(value: 15, unit: "ml"),
                imperial: Unit(value: 1, unit: "tbsp")
            )
        ),
        Ingredient(
            id: 2,
            name: "Garlic",
            quantity: Quantity(
                base: 2,
                metric: Unit(value: 2, unit: "cloves"),
                imperial: Unit(value: 2, unit: "cloves")
            )
        ),
        Ingredient(
            id: 3,
            name: "Bell Pepper",
            quantity: Quantity(
                base: 1,
                metric: Unit(value: 1, unit: "piece"),
                imperial: Unit(value: 1, unit: "piece")
            )
        ),
        Ingredient(
            id: 4,
            name: "Broccoli Florets",
            quantity: Quantity(
                base: 150,
                metric: Unit(value: 150, unit: "g"),
                imperial: Unit(value: 1, unit: "cup")
            )
        ),
        Ingredient(
            id: 5,
            name: "Soy Sauce",
            quantity: Quantity(
                base: 30,
                metric: Unit(value: 30, unit: "ml"),
                imperial: Unit(value: 2, unit: "tbsp")
            )
        ),
    ],
    cookingInstructions: [
        "Heat vegetable oil in a pan over medium heat.",
        "Add garlic and sauté until fragrant.",
        "Add vegetables and stir-fry for 4–5 minutes.",
        "Add soy sauce and toss to coat.",
        "Serve hot.",
    ],
    dietaryAttributes: ["vegetarian", "vegan"]
)

extension Recipe {
    static let sample = sampleRecipe
}
