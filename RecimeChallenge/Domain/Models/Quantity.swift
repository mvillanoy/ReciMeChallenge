//
//  Quantity.swift
//  RecimeChallenge
//
//  Created by Monica Villanoy on 1/17/26.
//
enum MeasurementSystem: String, CaseIterable, Identifiable {
    case metric = "Metric"
    case imperial = "Imperial"
    var id: String { rawValue }
}

struct Quantity: Codable {
    let base: Double
    let metric: Unit
    let imperial: Unit

    enum CodingKeys: String, CodingKey {
        case base
        case metric
        case imperial
    }
    
    init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)

          self.base = try container.decode(Double.self, forKey: .base)
          self.metric = try container.decode(Unit.self, forKey: .metric)
          self.imperial = try container.decode(Unit.self, forKey: .imperial)
      }

      init(
          base: Double,
          metric: Unit,
          imperial: Unit
      ) {
          self.base = base
          self.metric = metric
          self.imperial = imperial
      }
}
