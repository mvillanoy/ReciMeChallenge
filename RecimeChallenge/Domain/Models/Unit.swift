//
//  Metric.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/17/26.
//

struct Unit: Codable {
    let value: Double
    let unit: String

    enum CodingKeys: String, CodingKey {
        case value
        case unit
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.value = try container.decode(Double.self, forKey: .value)
        self.unit = try container.decode(String.self, forKey: .unit)
    }

    init(
        value: Double,
        unit: String
    ) {
        self.value = value
        self.unit = unit
    }
}
