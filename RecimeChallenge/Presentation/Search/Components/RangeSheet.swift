//
//  RangeSheet.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/19/26.
//

import SwiftUI

struct RangeSheet: View {
    @Binding var selectedServing: Double
    let title: String
    let subtitle: String
    var range: ClosedRange<Double>
    var accentColor: Color

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                        .padding(8)
                }
            }
            .padding(.top, 8)

            Text(subtitle)
                .font(.headline)
                .padding(.top)

            Slider(
                value: $selectedServing,
                in: range,
                step: 1
            )
            .accentColor(accentColor)
            .padding(.horizontal)

            Text("\(Int(selectedServing)) servings")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button {
                selectedServing = 0
                dismiss()
            } label: {
                Text("Clear Filter")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            Spacer()
        }

        .padding()
        .presentationDetents([.medium])
        .background(.sheetBackground)

    }

}
