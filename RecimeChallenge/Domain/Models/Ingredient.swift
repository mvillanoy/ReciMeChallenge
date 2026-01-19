//
//  Ingredient.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/16/26.
//

struct Ingredient: Codable {
    let id: Int
    let name: String
    let quantity: Quantity

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.quantity = try container.decode(Quantity.self, forKey: .quantity)
    }

    init(
        id: Int,
        name: String,
        quantity: Quantity
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
}
