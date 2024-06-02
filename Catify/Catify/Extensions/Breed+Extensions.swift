//
//  Breed+Extensions.swift
//  Catify
//
//  Created by Afonso Rosa on 02/06/2024.
//

import Foundation

extension Breed {

    var minimumLifeSpan: Int? {

        if let minimum = self.lifeSpan.components(separatedBy: " ").first {

            return Int(minimum)
        }

        return nil
    }
}

extension Collection where Element == Breed {

    var averageMinimumLifeSpan: Double? {

        let uniqueBreedsLifeSpan = Set(self).compactMap { $0.minimumLifeSpan }

        guard uniqueBreedsLifeSpan.count > 0 else { return nil }

        let lifeSpanSum = uniqueBreedsLifeSpan.reduce(into: 0) { partialResult, lifeSpan in
            partialResult += lifeSpan
        }

        return Double(lifeSpanSum / uniqueBreedsLifeSpan.count)
    }
}
