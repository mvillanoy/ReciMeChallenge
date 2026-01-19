//
//  IngredientItem.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/19/26.
//

import SwiftUI

struct IngredientItem: View {
    let ingredient: Ingredient
    let baseServings: Int
    @Binding var measurementSystem: MeasurementSystem
    @Binding var currentServings: Int

    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            Circle()
                .fill(Color.orange)
                .frame(width: 8, height: 8)
                .padding(.top, 6)
                .padding(.trailing, 8)

            Text(formattedQuantity)
                .font(.body)
                .fontWeight(.bold)
            Text("of \(ingredient.name)")
                .font(.body)
            Spacer()
        }
        .padding(.leading, 8)
    }

    private var formattedQuantity: String {
        let factor = Double(currentServings) / Double(baseServings)

        let quantity =
            measurementSystem == .imperial
            ? ingredient.quantity.imperial
            : ingredient.quantity.metric

        let value = quantity.value * factor
        return "\(value) \(quantity.unit)"
    }
}
