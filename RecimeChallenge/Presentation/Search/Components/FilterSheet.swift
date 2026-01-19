//
//  FilterSheet.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/19/26.
//

import SwiftUI
struct FilterSheet: View {
    let title: String
    let options: [String]
    var accentColor: Color
    
    @Binding var selectedOptions: Set<String>
    @Binding var isExclude: Bool

    @Environment(\.dismiss) private var dismiss

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

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
                
                HStack {
                    Button {
                        isExclude.toggle()
                    } label: {
                        HStack {
                            Image(systemName: isExclude ? "checkmark.square.fill" : "square")
                                .foregroundColor(isExclude ? accentColor : .primary)
                            Text("Exclude selected")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 4)


                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(options, id: \.self) { option in
                        let key = option.lowercased()

                        Button {
                            toggle(option: key)
                        } label: {
                            Text(option)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(
                                    selectedOptions.contains(key)
                                    ? accentColor
                                    : Color(.systemGray6)
                                )
                                .foregroundColor(
                                    selectedOptions.contains(key)
                                    ? .white
                                    : .primary
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            selectedOptions.contains(key)
                                            ? accentColor
                                            : Color(.systemGray4),
                                            lineWidth: 1
                                        )
                                )
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding(16)
        }
        .presentationDetents([.medium])
        .background(.sheetBackground)
    }

    private func toggle(option: String) {
        if selectedOptions.contains(option) {
            selectedOptions.remove(option)
        } else {
            selectedOptions.insert(option)
        }
    }
}
